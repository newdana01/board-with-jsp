<%--
  Created by IntelliJ IDEA.
  User: joo
  Date: 2020-09-21
  Time: 오후 3:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>답글 쓰기</title>
</head>
<body>
<%
    int num = Integer.parseInt(request.getParameter("num").trim());
%>
<h2 align="center">답글 쓰기</h2>
<form action="boardRewriteProc.jsp" method="post">
    <table width="600" align="center" border="1">
        <tr height="50">
            <td width="150" align="center">작성자</td>
            <td width="450" align="center"><input type="text" name="writer" size="50"></td>
        </tr>
        <tr height="50">
            <td width="150" align="center">제목</td>
            <td width="450" align="center"><input type="text" name="title" size="50" value="[답변]"></td>
        </tr>
        <tr height="50">
            <td width="150" align="center">이메일</td>
            <td width="450" align="center"><input type="email" name="email" size="50"></td>
        </tr>
        <tr height="50">
            <td width="150" align="center">비밀번호</td>
            <td width="450" align="center"><input type="password" name="pass" size="50"></td>
        </tr>
        <tr height="80">
            <td width="150" align="center">내용</td>
            <td><textarea name="contents" cols="60" rows="10"></textarea></td>
        </tr>
        <tr height="50">
            <td width="150" align="center" colspan="2">
                <input type="hidden" name ="num" value="<%=num%>">
                <input type="submit" value="글쓰기">&nbsp;&nbsp;
                <input type="reset" value="초기화">&nbsp;&nbsp;
                <input type="button" value="전체 게시글 보기" onclick="location.href='boardList.jsp'" >
            </td>
        </tr>
    </table>
</form>
</body>
</html>
