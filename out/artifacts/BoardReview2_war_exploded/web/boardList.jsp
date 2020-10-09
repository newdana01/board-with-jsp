<%@ page import="module.BoardDAO" %>
<%@ page import="module.BoardDTO" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: joo
  Date: 2020-09-09
  Time: 오전 11:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>글 목록</title>
</head>
<body>
<%
    int pageSize = 10;
    String pageNum = request.getParameter("pageNum");
    if(pageNum==null) pageNum="1";
    int currentPage = Integer.parseInt(pageNum);

    int count;
    int number;

    BoardDAO boardDAO = new BoardDAO();
    count = boardDAO.getAllCount();

    int startRow = (currentPage-1) * pageSize +1;
    int endRow = currentPage * pageSize;

    ArrayList<BoardDTO> list = boardDAO.getList(startRow, endRow);

    number = count - (currentPage-1) * pageSize;
%>
<h2 align="center">글 목록</h2>
<table align="center" width="750" border="1">
    <tr height="40">
        <td colspan="5" align="right">
            <button onclick="location.href='boardWriteForm.jsp'">글쓰기</button>
        </td>
    </tr>
    <tr height="40">
        <td width="50" align="center">번호</td>
        <td width="250" align="center">글 제목</td>
        <td width="150" align="center">작성자</td>
        <td width="200" align="center">작성일</td>
        <td width="100" align="center">조회수</td>
    </tr>
    <%
        for(int i=0; i<list.size(); i++){
            BoardDTO boardDTO = list.get(i);

    %>
    <tr height="40">
        <td width="100" align="center"><%=number--%></td>
        <td width="250">
            <a href="boardInfo.jsp?num=<%=boardDTO.getNum()%>" style="text-decoration: none">
                <%
                    if(boardDTO.getRe_step() > 1){
                        for(int j=0; j < (boardDTO.getRe_step()-1)*3; j++){
                %>
                &nbsp;
                <%
                        }
                    }
                %>
                <%=boardDTO.getTitle()%></a>
        </td>
        <td width="150" align="center"><%=boardDTO.getWriter()%></td>
        <td width="200" align="center"><%=boardDTO.getReg_date()%></td>
        <td width="100" align="center"><%=boardDTO.getRead_count()%></td>
    </tr>
    <%
        }
    %>
</table>
<p align="center">
    <%
        if(count > 0){
            int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
            int startPage = 1;
            if(currentPage % 10 != 0){
                startPage = (currentPage / 10) * 10 + 1;
            }else {
                startPage = ((currentPage / 10) -1) * 10 + 1;
            }

            int pageBlock = 10;
            int endPage = startPage + pageBlock - 1;

            if(endPage > pageCount) endPage = pageCount;

            if(startPage > pageBlock){
    %>
    <a href="boardList.jsp?pageNum=<%=startPage-10%>">[이전]</a>
    <%
        }
        for(int i = startPage; i <= endPage; i++){
    %>
    <a href="boardList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
    <%
        }
        if(endPage < pageCount){
    %>
    <a href="boardList.jsp?pageNum=<%=startPage+10%>">[다음]</a>
    <%
            }
        }
    %>
</p>
</body>
</html>
