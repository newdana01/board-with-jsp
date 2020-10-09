<%@ page import="module.BoardDAO" %>
<%@ page import="module.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: joo
  Date: 2020-09-22
  Time: 오후 5:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num"));
    String pass = request.getParameter("pass");

    BoardDAO boardDAO = new BoardDAO();
    String daoPass = boardDAO.getPass(num);

    if(pass.equals(daoPass)){
        boardDAO.deleteOneBoard(num);
        response.sendRedirect("boardList.jsp");
    }else{
%>
<script type="text/javascript">
    alert("패스워드가 일치하지 않습니다.");
    history.back();
</script>
<%
    }
%>
</body>
</html>
