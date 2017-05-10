<%@ page import="java.io.*,java.util.*"  %>
<html>
<body>
<%
// New location to be redirected
String site = new String("https://accounts.google.com/o/oauth2/auth?scope=email%20profile&state=%2Fprofile&"
+"redirect_uri=https://1-dot-todo-vijju.appspot.com/get&"+
"response_type=code&"+
"client_id=643071805966-n4jfq2ssfv4sj3k8mhd44ninkvqr9fie.apps.googleusercontent.com");
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", site); 
%>
</body></html>


<%-- <%@ page import="java.io.*,java.util.*"  %>
<html>
<body>
<%
// New location to be redirected
String site = new String("https://accounts.google.com/o/oauth2/auth?scope=email%20profile&state=%2Fprofile&"
+"redirect_uri=http://1-dot-vighneswari-1162.appspot.com/get&"+
"response_type=code&"+
"client_id=141292453722-850cv5btpogjsvev3sks7e1mkbbo07d2.apps.googleusercontent.com");
response.setStatus(response.SC_MOVED_TEMPORARILY);
response.setHeader("Location", site); 
%>
</body></html> --%>