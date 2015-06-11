<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>
<!DOCTYPE html>
<!-- <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!--  Bootstrap related -->
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="<c:url value="/resources/scripts/bootstrap/css/bootstrap.min.css"/>">
<title>Logout :: Learn WebSockets</title>
</head>
<body>
  <div class="container">
    <div class="span12">
      <div id="heading" class="masthead">
        <h3 class="muted">Logged Out</h3>
      </div>
      <div class="row">
        <div class="col-sm-12">
          <div class="panel panel-default">
            <div class="panel-body">
              Your session has ended. Click here 
              to <a href="${pageContext.request.contextPath}/secured/basicWebsockets">login</a>
              again.
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Compiled and minified JQuery JavaScript (necessary for Bootstrap's JavaScript plugins). 
    Placed at the end of the document so the pages load faster -->
  <script src="<c:url value="/resources/scripts/jquery-1.10.2.min.js"/>"></script>
  <!-- Include all compiled plugins (below), or include individual files as needed -->
  <script src="<c:url value="/resources/scripts/bootstrap/js/bootstrap.min.js"/>"></script>
</body>
</html>