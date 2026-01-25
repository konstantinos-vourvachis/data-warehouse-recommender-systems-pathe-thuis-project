CREATE VIEW pathe.PersonalizedRecommendations AS
SELECT 
    dc.Name AS CustomerName,
    dm.Title AS MovieTitle,
    dm.GenreName AS Genre,
    dm.ReleaseDate,
    ft.EngagementScoreCustomer AS EngagementScore,  
    AVG(ft.RatingValue) AS AverageRating
FROM 
    pathe.DimensionCustomerRecommendationsWatchHistory dc
JOIN 
    pathe.Fact_Table_CustomerEngagement ft
    ON dc.CustomerLogsID = ft.CustomerLogsID  
JOIN 
    pathe.DimensionMovieGenreActor dm
    ON ft.MovieID = dm.MovieID
WHERE 
    ft.RatingValue >= 4 
GROUP BY 
    dc.Name, 
    dm.Title, 
    dm.GenreName, 
    dm.ReleaseDate, 
    ft.EngagementScoreCustomer  
ORDER BY 
    ft.EngagementScoreCustomer DESC,  
    AverageRating DESC;