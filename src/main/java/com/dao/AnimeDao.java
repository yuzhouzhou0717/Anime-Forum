package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import com.bean.Anime;
import com.util.DatabaseUtils;

public class AnimeDao {

    public List<Anime> getAllAnime() {
        List<Anime> animeList = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DatabaseUtils.getConnection();
            statement = connection.prepareStatement("SELECT * FROM anime");
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Anime anime = new Anime();
                anime.setId(resultSet.getInt("id"));
                anime.setName(resultSet.getString("name"));
                anime.setImagePath(resultSet.getString("image_path"));

                animeList.add(anime);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // 处理异常
        } finally {
            DatabaseUtils.closeConnection(connection, statement, resultSet);
        }

        return animeList;
    }
}
