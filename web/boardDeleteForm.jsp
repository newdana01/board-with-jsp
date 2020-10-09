<%@ page import="module.BoardDAO" %>
<%@ page import="module.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: joo
  Date: 2020-09-22
  Time: 오후 5:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>게시글 삭제</title>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num").trim());
    BoardDAO boardDAO = new BoardDAO();
    BoardDTO boardDTO = boardDAO.getOneBoard(num);
%>
<h2 align="center">게시글 삭제</h2>
<form action="boardDeleteProc.jsp" method="post">
    <table width="600" align="center" border="1">
        <tr height="50">
            <td width="100" align="center">작성자</td>
            <td width="200" align="center"><%=boardDTO.getWriter()%></td>
            <td width="100" align="center">작성일</td>
            <td width="200" align="center"><%=boardDTO.getReg_date()%></td>
        </tr>
        <tr height="50">
            <td width="100" align="center">제목</td>
            <td colspan="3" align="center"><%=boardDTO.getTitle()%></td>
        </tr>
        <tr height="50">
            <td width="100" align="center">패스워드</td>
            <td colspan="3" align="center"><input type="password" name="pass" size="70"></td>
        </tr>
        <tr height="50">
            <td colspan="4" align="center">
                <input type="hidden" name="num" value="<%=num%>">
                <input type="submit" value="글 삭제">
                <input type="button" onclick="location.href='boardList.jsp'" value="전체목록">
            </td>
        </tr>
    </table>
</form>
</body>
</html>
