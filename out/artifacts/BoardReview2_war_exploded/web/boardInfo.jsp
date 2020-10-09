<%@ page import="module.BoardDAO" %>
<%@ page import="module.BoardDTO" %><%--
  Created by IntelliJ IDEA.
  User: joo
  Date: 2020-09-09
  Time: 오후 9:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글 상세보기</title>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num").trim());
    BoardDAO boardDAO = new BoardDAO();
    BoardDTO boardDTO = boardDAO.getOneBoard(num);
%>
<h2 align="center">글 내용 보기</h2>
<table width="600" align="center" border="1">
    <tr height="50">
        <td width="100" align="center">글 번호</td>
        <td width="200" align="center"><%=boardDTO.getNum()%></td>
        <td width="100" align="center">조회수</td>
        <td width="200" align="center"><%=boardDTO.getRead_count()%></td>
    </tr>
    <tr height="50">
        <td width="100" align="center">작성자</td>
        <td width="200" align="center"><%=boardDTO.getWriter()%></td>
        <td width="100" align="center">작성일</td>
        <td width="200" align="center"><%=boardDTO.getReg_date()%></td>
    </tr>
    <tr height="50">
        <td width="100" align="center">이메일</td>
        <td align="center" colspan="3"><%=boardDTO.getEmail()%></td>
    </tr>
    <tr height="50">
        <td width="100" align="center">글 제목</td>
        <td align="center" colspan="3"><%=boardDTO.getTitle()%></td>
    </tr>
    <tr height="50">
        <td width="100" align="center">내용</td>
        <td align="center" colspan="3"><%=boardDTO.getContents()%></td>
    </tr>
    <tr height="50">
        <td align="center" colspan="4">
            <button onclick="location.href='boardRewriteForm.jsp?num=<%=boardDTO.getNum()%>'">답글쓰기</button>
            <button onclick="location.href='boardUpdateForm.jsp?num=<%=boardDTO.getNum()%>'">수정하기</button>
            <button onclick="location.href='boardDeleteForm.jsp?num=<%=boardDTO.getNum()%>'">삭제하기</button>
            <button onclick="location.href='boardList.jsp'">전체목록</button>
        </td>
    </tr>
</table>
</body>
</html>
