<%@ page import="module.BoardDAO" %><%--
  Created by IntelliJ IDEA.
  User: joo
  Date: 2020-09-22
  Time: 오후 6:05
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
    String daoPass = boardDAO.getPass(boardDTO.getNum());
    if(boardDTO.getPass().equals(daoPass)){
        boardDAO.update(boardDTO);
        response.sendRedirect("boardInfo.jsp?num="+boardDTO.getNum());
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
