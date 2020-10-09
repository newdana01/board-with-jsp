package module;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
    DataSource dataSource;
    Connection con;
    PreparedStatement psmt;
    ResultSet res;

    public void getCon() {
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/mysqlDB");
            con = dataSource.getConnection();
        } catch (Exception e1) {
            e1.printStackTrace();
            try {
                if (con != null) con.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    public void useDatabase() {
        try {
            psmt = con.prepareStatement("USE boardreview");
            psmt.execute();
        } catch (Exception e1) {
            e1.printStackTrace();
            try{
                if(con!=null) con.close();
                if(psmt!=null) psmt.close();
            }catch (Exception e2){
                e2.printStackTrace();
            }
        }
    }

    public void insertNew(BoardDTO boardDTO) {
        getCon();
        useDatabase();

        int ref = 0;
        int re_step = 1;
        int re_level = 1;

        try {
            psmt = con.prepareStatement("SELECT max(ref) FROM board_r");
            res = psmt.executeQuery();
            psmt.clearParameters();

            if (res.next()) {
                ref = res.getInt(1) + 1;
            }

            String sql = "INSERT INTO board_r VALUES (0, ?, ?, ?, ?, 0, ?, ?, ?, now(), ?)";
            psmt = con.prepareStatement(sql);
            psmt.setString(1, boardDTO.getWriter());
            psmt.setString(2, boardDTO.getEmail());
            psmt.setString(3, boardDTO.getTitle());
            psmt.setString(4, boardDTO.getPass());
            psmt.setInt(5, ref);
            psmt.setInt(6, re_step);
            psmt.setInt(7, re_level);
            psmt.setString(8, boardDTO.getContents());
            psmt.executeUpdate();

        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            try {
                if (res != null) res.close();
                if (psmt != null) psmt.close();
                if (con != null) con.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }

    public ArrayList<BoardDTO> getList(int startRow, int endRow) {
        getCon();
        useDatabase();
        ArrayList<BoardDTO> list = new ArrayList<>();

        try {
            String sql = "SELECT C.* FROM (SELECT A.*, @ROWNUM := @ROWNUM+1 rownum FROM board_r A, (SELECT @ROWNUM:=0)B ORDER BY ref DESC, re_step ASC, re_level ASC) C "
                    +"WHERE rownum >= ? AND rownum <= ?";
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, startRow);
            psmt.setInt(2, endRow);
            res = psmt.executeQuery();

            while(res.next()){
                BoardDTO boardDTO = new BoardDTO();

                boardDTO.setNum(res.getInt(1));
                boardDTO.setWriter(res.getString(2));
                boardDTO.setEmail(res.getString(3));
                boardDTO.setTitle(res.getString(4));
                boardDTO.setPass(res.getString(5));
                boardDTO.setRead_count(res.getInt(6));
                boardDTO.setRef(res.getInt(7));
                boardDTO.setRe_step(res.getInt(8));
                boardDTO.setRe_level(res.getInt(9));
                boardDTO.setReg_date(res.getString(10));
                boardDTO.setContents(res.getString(11));

                list.add(boardDTO);
            }
        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            try {
                if (res != null) res.close();
                if (psmt != null) psmt.close();
                if (con != null) psmt.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return list;
    }

    public int getAllCount() {
        getCon();
        useDatabase();
        int count=0;

        try {
            String sql = "SELECT count(*) FROM board_r";
            psmt = con.prepareStatement(sql);
            res = psmt.executeQuery();

            if(res.next()){
                count = res.getInt(1);
            }

        } catch (Exception e1) {
            e1.printStackTrace();
        } finally {
            try {
                if (res != null) res.close();
                if (psmt != null) psmt.close();
                if (con != null) psmt.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
        return count;
    }

    public BoardDTO getOneBoard(int num){
        BoardDTO boardDTO = new BoardDTO();

        getCon();
        useDatabase();

        try{
            String sql_up = "UPDATE board_r SET readCount = readCount+1 WHERE num=?";
            psmt = con.prepareStatement(sql_up);
            psmt.setInt(1, num);
            psmt.executeUpdate();
            psmt.clearParameters();
            
            String sql = "SELECT * FROM board_r WHERE num=?";
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, num);
            res = psmt.executeQuery();

            if(res.next()){
                boardDTO.setNum(res.getInt(1));
                boardDTO.setWriter(res.getString(2));
                boardDTO.setEmail(res.getString(3));
                boardDTO.setTitle(res.getString(4));
                boardDTO.setPass(res.getString(5));
                boardDTO.setRead_count(res.getInt(6));
                boardDTO.setRef(res.getInt(7));
                boardDTO.setRe_step(res.getInt(8));
                boardDTO.setRe_level(res.getInt(9));
                boardDTO.setReg_date(res.getString(10));
                boardDTO.setContents(res.getString(11));
            }

        }catch (Exception e1){
            e1.printStackTrace();
        }finally {
            try {
                if (res!=null) res.close();
                if (psmt != null) psmt.close();
                if (con != null) psmt.close();
            }catch (Exception e2){
                e2.printStackTrace();
            }
        }
        return boardDTO;
    }

    public void rewrite(BoardDTO boardDTO) {
        getCon();
        useDatabase();

        int ref = 1;
        int re_step = 1;
        int re_level = 1;

        try{
            String sqlStep = "SELECT ref, re_step, re_level FROM board_r WHERE num = ?";
            psmt = con.prepareStatement(sqlStep);
            psmt.setInt(1, boardDTO.getNum());
            res = psmt.executeQuery();

            if(res.next()){
                ref = res.getInt(1);
                re_step = res.getInt(2);
                re_level = res.getInt(3);
            }

            String sqlLevel = "UPDATE board_r SET re_level = re_level + 1 WHERE ref = ? AND re_level > ?";
            psmt = con.prepareStatement(sqlLevel);
            psmt.setInt(1, ref);
            psmt.setInt(2, re_level);
            psmt.executeUpdate();
            psmt.clearParameters();

            String sql = "INSERT INTO board_r VALUES (0, ?, ?, ?, ?, 0, ?, ?, ?, now(), ?)";
            psmt = con.prepareStatement(sql);
            psmt.setString(1, boardDTO.getWriter());
            psmt.setString(2, boardDTO.getEmail());
            psmt.setString(3, boardDTO.getTitle());
            psmt.setString(4, boardDTO.getPass());
            psmt.setInt(5, ref);
            psmt.setInt(6, re_step + 1);
            psmt.setInt(7, re_level + 1);
            psmt.setString(8, boardDTO.getContents());
            psmt.executeUpdate();
        }catch (Exception e1){
            e1.printStackTrace();
        }finally {
            try{
                if (res!=null) res.close();
                if (psmt != null) psmt.close();
                if (con != null) psmt.close();
            }catch (Exception e2){
                e2.printStackTrace();
            }
        }
    }

    public String getPass(int num) {
        String pass = "";

        getCon();
        useDatabase();

        try{
            String sql = "SELECT pass FROM board_r WHERE num = ?";
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, num);
            res = psmt.executeQuery();

            if(res.next()){
                pass = res.getString(1);
            }
        }catch (Exception e1){
            e1.printStackTrace();
        }finally {
            try{
                if (res!=null) res.close();
                if (psmt != null) psmt.close();
                if (con != null) psmt.close();
            }catch (Exception e2){
                e2.printStackTrace();
            }
        }

        return pass;
    }

    public void deleteOneBoard(int num) {
        getCon();
        useDatabase();

        try{
            String sql = "DELETE FROM board_r WHERE num = ?";
            psmt = con.prepareStatement(sql);
            psmt.setInt(1, num);
            psmt.executeUpdate();
        }catch (Exception e1){
            e1.printStackTrace();
        }finally {
            try{
                if (psmt != null) psmt.close();
                if (con != null) psmt.close();
            }catch (Exception e2){
                e2.printStackTrace();
            }
        }
    }

    public void update(BoardDTO boardDTO) {
        getCon();
        useDatabase();

        try{
            String sql = "UPDATE board_r SET title = ?, contents= ? WHERE num = ?";
            psmt = con.prepareStatement(sql);
            psmt.setString(1, boardDTO.getTitle());
            psmt.setString(2, boardDTO.getContents());
            psmt.setInt(3, boardDTO.getNum());
            psmt.executeUpdate();
        }catch (Exception e1){
            e1.printStackTrace();
        }finally {
            try {
                if (psmt != null) psmt.close();
                if (con != null) psmt.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
    }
}
