<%@ page import="module.BoardDAO" %><%--
  Created by IntelliJ IDEA.
  User: joo
  Date: 2020-09-21
  Time: 오후 3:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="boardDTO" class="module.BoardDTO">
    <jsp:setProperty name="boardDTO" property="*"/>
</jsp:useBean>
<%
    BoardDAO boardDAO = new BoardDAO();
    boardDAO.rewrite(boardDTO);
    response.sendRedirect("boardList.jsp");
%>
</body>
</html>
