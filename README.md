Jsp/Servlet CRUD 게시판
=============

## 개발 환경
   * Windows10, Eclipse, Open-JDK(1.8)
## 기술 스택
   * Back-end : java(jsp/servlet), Mysql, Apache/Tomcat
   * Front-end : HTML5, CSS, bootstrap
   * library
      + Apache pool2-2.4.1, logging-1.2, dbcp2-2.1
      + JSTL(1.2)
      + MYSQL(mysql-connector-java-8.0.20)
## 프로젝트 기능
   * 회원(주요 코드 : [비밀번호변경](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/member/service/ChangePasswordService.java), [임시비밀번호발급](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/member/service/SearchPasswordService.java), [로그인](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/auth/service/LoginService.java))
      + 로그인/로그아웃 기능
      + 비밀번호 변경/임시 비밀번호 발급 기능
   * 게시판(주요 코드 : [게시글 등록](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/article/service/WriteArticleService.java), [게시글 조회](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/article/service/ReadArticleService.java), [게시글 수정](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/article/service/ModifyArticleService.java), [게시글 삭제](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/article/service/DeleteArticleService.java), [게시판 목록](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/article/service/ListArticleService.java))
      + 게시글 등록/조회/수정/삭제
      + 게시판 목록 조회(페이징 처리)
## 주요 클래스
### DBCP(DataBase Connection Pool)
  * 어플리케이션 실행 속도를 향상시키기 위해, 커넥션 풀 기법을 사용하였습니다.
  * 범용적인 자카르타 DBCP2 API를 사용하였고, 이에 관련하여 학습하였습니다.

![image](https://user-images.githubusercontent.com/48613137/114556370-9b0f3700-9ca3-11eb-8c5a-5157bd25bca3.png)
  * 주요 코드 리뷰
    - [DBCPInitListener.java](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/jdbc/DBCPInitListener.java)
      + 드라이버 로딩 : 커넥션 풀이 내부에서 사용할 JDBC 드라이버를 로딩, 해당 프로젝트는 Mysql용 JDBC 드라이버 로딩
        ```
        private void loadJDBCDriver(Properties prop) {
            String driverClass = prop.getProperty("jdbcdriver");
            try {
              Class.forName(driverClass);
            } catch (ClassNotFoundException ex) {
              throw new RuntimeException("fail to load JDBC Driver", ex);
            }
	      }
        ```
      + 커넥션 풀 설정 및 등록
        + 새로운 커넥션을 생성할 때 사용할 커넥션 팩토리 생성 : Mysql Url과 계정정보를 전달.
        ```
        ConnectionFactory connFactory = 
            new DriverManagerConnectionFactory(jdbcUrl, username, pw);
        ```
        + PoolableConnectio을 생성하는 팩토리 생성 : 커넥션을 보관할 때 사용
        ```
        PoolableConnectionFactory poolableConnFactory = 
            new PoolableConnectionFactory(connFactory, null);
        ```
        + 커넥션 유효성 검사 : [web.xml](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/WebContent/WEB-INF/web.xml)에 poolConfig로 등록한 파라미터의 validationQuery 사용
        ```
        String validationQuery = prop.getProperty("validationQuery");
        if (validationQuery != null && !validationQuery.isEmpty()) {
            poolableConnFactory.setValidationQuery(validationQuery);
        ```
        + 커넥션 풀 설정 정보 생성 : 유휴 커넥션 검사 주기, 풀에 있는 커넥션 유효성 검사 여부, 커넥션 최소 개수, 커넥션 최대 개수 등을 설정
        ```
        GenericObjectPoolConfig poolConfig = new GenericObjectPoolConfig();
        poolConfig.setTimeBetweenEvictionRunsMillis(1000L * 60L * 5L);
        poolConfig.setTestWhileIdle(true);
        int minIdle = getIntProperty(prop, "minIdle", 5);
        poolConfig.setMinIdle(minIdle);
        int maxTotal = getIntProperty(prop, "maxTotal", 50);
        poolConfig.setMaxTotal(maxTotal);
        ```
        + 커넥션 풀 생성 및 연결 : 커넥션 팩토리와 커넥션 풀 설정을 파라미터로 전달
        ```
        GenericObjectPool<PoolableConnection> connectionPool = 
					new GenericObjectPool<>(poolableConnFactory, poolConfig);
			  poolableConnFactory.setPool(connectionPool);
        ```
        + 커넥션 풀을 제공하는 JDBC 드라이버 등록
        ```
        Class.forName("org.apache.commons.dbcp2.PoolingDriver");
        ```
        + 커넥션 풀 드라이버에 생성한 커넥션 풀 등록 : 프로그램에서 사용될 URL : "jdbc:apache:commons:dbcp:board"
        ```
        PoolingDriver driver = (PoolingDriver)
          DriverManager.getDriver("jdbc:apache:commons:dbcp:");
        String poolName = prop.getProperty("poolName");
        driver.registerPool(poolName, connectionPool);
        ```
### Filter : [CharacterEncodingFilter](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/util/CharacterEncodingFilter.java), [LoginCheckerFilter](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/filter/LoginCheckFilter.java)
  * 캐릭터 인코딩을 한 코드에서 설정하도록 구현하였습니다.
  * 회원일 때 이용 가능한 기능을 접근할 때 인증 여부 확인합니다.
  * [CharacterEncodingFilter](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/util/CharacterEncodingFilter.java)
    - 필터를 초기화 하기 위한 init, 필터 기능을 수행하는 doFilter를 Overriding.
    - [web.xml](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/WebContent/WEB-INF/web.xml)에 필터를 적용하도록 등록합니다.
  * [LoginCheckerFilter](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/filter/LoginCheckFilter.java)
    - 캐릭터 인코딩 필터와 같이 init과 doFilter를 구현하고 web.xml에 필터를 적용하도록 등록합니다.
      + web.xml 파일 설정에 따라 관련 url 요청이 들어오면 필터 동작
      ```
      <filter-mapping>
		  <filter-name>LoginCheckFilter</filter-name>
		  <url-pattern>/changePwd.do</url-pattern>
		  <url-pattern>/article/write.do</url-pattern>
		  <url-pattern>/article/modify.do</url-pattern>
      </filter-mapping>
      ```
### MVC Controller : [ControllerUsingURI](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/mvc/controller/ControllerUsingURI.java), [CommandHandler](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/mvc/command/CommandHandler.java)
  * Servlet을 이용하여 모델2 구조를 이용한 MVC 패턴을 구현하였습니다.
  * 프로그램에서 Servlet은 Controller의 역할을 수행합니다.
  * 각각의 로직 처리 코드를 별도 클래스로 작성하여 커맨드 패턴을 적용하였습니다.
  * [CommandHandler.properties](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/WebContent/WEB-INF/commandHandlerURI.properties)에 등록된 매핑 정보를 사용하여 Handler 객체를 이용, 요청을 처리하고 전달합니다.
    - [ControllerUsingURI](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/mvc/controller/ControllerUsingURI.java)
      + configFile 초기화 파라미터의 값을 읽어옴.
      ```
      String configFile = getInitParameter("configFile");
      ```
      + 설정 파일로 부터 매핑 정보를 읽어와 Properties 객체에 저장.
      + Properties에서 프로퍼티 이름을 커맨드 이름, 값을 클래스 이름으로 사용.
      ```
      try (FileReader fis = new FileReader(configFilePath)) {
          prop.load(fis);
      } catch (IOException e) {
          throw new ServletException(e);
      }
      ```
      + 각 프로퍼티에 키에 대해 관련 작업을 반복.
      + 1. 프로퍼티 이름을 커맨드 이름으로 사용.
      + 2. 커맨드 이름에 해당하는 핸들러 클래스 이름을 Properties에서 구함.
      + 3. 핸들러 클래스 이름을 이용해서 Class 객체 구현.
      + 4. Class로 부터 핸들러 객체 생성
      + 5. commandHandlerMap에 매핑 정보 저장.
      ```
      Iterator keyIter = prop.keySet().iterator();
      while (keyIter.hasNext()) {
          String command = (String) keyIter.next();
          String handlerClassName = prop.getProperty(command);
          try {
              Class<?> handlerClass = Class.forName(handlerClassName);
              CommandHandler handlerInstance = 
                      (CommandHandler) handlerClass.newInstance();
              commandHandlerMap.put(command, handlerInstance);
          } catch (ClassNotFoundException | InstantiationException 
            | IllegalAccessException e) {
              throw new ServletException(e);
          }
        }
      }
      ```
      + commandHandlerMap에서 요청을 처리할 핸들러 객체를 구함.
      ```
      private void process(HttpServletRequest request,
      HttpServletResponse response) throws ServletException, IOException {
		          String command = request.getRequestURI();
		          if (command.indexOf(request.getContextPath()) == 0) {
			        command = command.substring(request.getContextPath().length());
		          }
          CommandHandler handler = commandHandlerMap.get(command);
      ```
      + 구해온 핸들러 객체의 process() 메서드를 호출해서 요청을 처리하고, 뷰 페이지 경로를 리턴받음.
      + 핸들러 인스턴스의 process()는 각 클라이언트의 요청을 알맞게 처리하고 결과값을 request나 session의 속성에 저장.
      ```
      try {
          viewPage = handler.process(request, response);
      } catch (Throwable e) {
          throw new ServletException(e);
      }
      if (viewPage != null) {
	      RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
	      dispatcher.forward(request, response);
      }
      ```
      + viewPage가 null이 아니면, 핸들러 인스턴스가 리턴한 뷰 페이지로 이동.
      ```
      if (viewPage != null) {
	      RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
	      dispatcher.forward(request, response);
      }
      ```
### 비밀번호 암호화 및 임시비밀번호 발급 : [Utility.java](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/auth/security/Utility.java), [TemporaryPassword.java](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/auth/security/TemporaryPassword.java)
  * 해시 알고리즘을 사용하기 위해 MessageDigest 라이브러리를 사용하였습니다.
  * 여러 알고리즘 중 미국 국립표준기술연구소(NIST)에서 공표한 SHA-2 계열 중 SHA-256을 적용하였습니다.
  * 임시비밀번호는 임의의 10개의 문자열로 구성하여 유저에게 제공합니다.
    - [Utility.java](https://github.com/SEONGBIN-PYO/jsp-servlet-CRUD/blob/dev/src/auth/security/Utility.java)
      + SHA-256을 대입하여 해당 메시지 다이제스트 객체를 만듦.
      + update()는 지정된 바이트 데이터를 사용해 다이제스트를 갱신.
      + digest()는 바이트 배열로 해쉬를 반환.
      + 반환된 바이트 배열을 String형태로 인코딩하여 반환.
      ```
      MessageDigest md = MessageDigest.getInstance("SHA-256");
      md.update(str.getBytes());
      byte[] encodeData = md.digest();
      
      for(int i = 0; i < encodeData.length; i++) {
				encodeString += Integer.toHexString(encodeData[i]&0xFF);
      }
      ```
