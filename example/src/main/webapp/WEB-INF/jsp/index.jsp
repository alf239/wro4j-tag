<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://ebi.ac.uk/gxa/tags/wro4j" prefix="wro4j" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<html>
<head>
    <script type="text/javascript" src="${contextPath}/js/jquery-1.7.2.min.js"></script>
    <wro4j:all name="bundle-all"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#testOne").click(function (ev) {
                ev.preventDefault();
                one();
            });

            $("#testTwo").click(function (ev){
                ev.preventDefault();
                two();
            });
        });
    </script>
</head>
<body>
<a href="#" id="testOne">Test One</a>
<a href="#" id="testTwo">Test Two</a>
</body>
</html>