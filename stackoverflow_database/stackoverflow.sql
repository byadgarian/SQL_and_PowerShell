--------------------------------------------------------------------------------------------------------------------------------------------
-- Author: Brian Y. Copyright © 2021. All rights reserved.                                                                                --
-- This single SQL query finds the top 3 StackOverflow posters per year per category (answers, questions, and comments) from 2008 to 2010.--
-- The query takes about 30 to 40 seconds to execute on a machine with Intel Core i7 processor and 16GB of RAM.                           --
-- The results are shown in snapshot.jpg                                                                                                  --
--------------------------------------------------------------------------------------------------------------------------------------------

SELECT T6.Yearr, T6.Rankk, T8.Answer, T7.Question, T6.Comment, T9.Total FROM((( 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfComments DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumofComments) AS Comment FROM( 
                        SELECT TOP 3 T2.NumOfComments, T2.Yearr, T2.UserId, T2.DisplayName, T3.NumOfQuestions, T4.NumOfAnswers, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2008 
                        ORDER BY T2.NumOfComments DESC) AS T5 
            UNION 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfComments DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumofComments) AS Comment FROM( 
                        SELECT TOP 3 T2.NumOfComments, T2.Yearr, T2.UserId, T2.DisplayName, T3.NumOfQuestions, T4.NumOfAnswers, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2009 
                        ORDER BY T2.NumOfComments DESC) AS T5 
            UNION 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfComments DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumofComments) AS Comment FROM( 
                        SELECT TOP 3 T2.NumOfComments, T2.Yearr, T2.UserId, T2.DisplayName, T3.NumOfQuestions, T4.NumOfAnswers, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2010 
                        ORDER BY T2.NumOfComments DESC) AS T5) AS T6 
INNER JOIN( 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfQuestions DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumOfQuestions) AS Question FROM( 
                        SELECT TOP 3 T3.NumOfQuestions, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, T4.NumOfAnswers, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2008 
                        ORDER BY T3.NumOfQuestions DESC) AS T5 
            UNION 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfQuestions DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumOfQuestions) AS Question FROM( 
                        SELECT TOP 3 T3.NumOfQuestions, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, T4.NumOfAnswers, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2009 
                        ORDER BY T3.NumOfQuestions DESC) AS T5 
            UNION 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfQuestions DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumOfQuestions) AS Question FROM( 
                        SELECT TOP 3 T3.NumOfQuestions, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, T4.NumOfAnswers, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2010 
                        ORDER BY T3.NumOfQuestions DESC) AS T5) AS T7 
ON T6.Yearr = T7.Yearr AND T6.Rankk = T7.Rankk) 
INNER JOIN( 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfAnswers DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumOfAnswers) AS Answer FROM( 
                        SELECT TOP 3 T4.NumOfAnswers, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, T3.NumOfQuestions, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2008 
                        ORDER BY T4.NumOfAnswers DESC) AS T5 
            UNION 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfAnswers DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumOfAnswers) AS Answer FROM( 
                        SELECT TOP 3 T4.NumOfAnswers, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, T3.NumOfQuestions, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2009 
                        ORDER BY T4.NumOfAnswers DESC) AS T5 
            UNION 
            SELECT T5.Yearr, RANK() OVER(ORDER BY T5.NumOfAnswers DESC) AS Rankk, CONCAT(T5.DisplayName, ': ',T5.NumOfAnswers) AS Answer FROM( 
                        SELECT TOP 3 T4.NumOfAnswers, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, T3.NumOfQuestions, 
                        ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2010 
                        ORDER BY T4.NumOfAnswers DESC) AS T5) AS T8 
ON T6.Yearr = T8.Yearr AND T6.Rankk = T8.Rankk) 
INNER JOIN( 
            SELECT T5.Yearr, RANK() OVER(ORDER BY ((T5.NumOfComments * 1) + (T5.NumOfQuestions * 2) + (T5.NumOfAnswers *3)) DESC) AS Rankk, CONCAT(T5.DisplayName, ': ', 
                        ((T5.NumOfComments * 1) + (T5.NumOfQuestions * 2) + (T5.NumOfAnswers *3)) ) AS Total FROM( 
                        SELECT TOP 3 ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, 
                        T3.NumOfQuestions, T4.NumOfAnswers FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2008 
                        ORDER BY TotalScore DESC) AS T5 
            UNION 
            SELECT T5.Yearr, RANK() OVER(ORDER BY ((T5.NumOfComments * 1) + (T5.NumOfQuestions * 2) + (T5.NumOfAnswers *3)) DESC) AS Rankk, CONCAT(T5.DisplayName, ': ', 
            ((T5.NumOfComments * 1) + (T5.NumOfQuestions * 2) + (T5.NumOfAnswers *3))) AS Total FROM( 
                        SELECT TOP 3 ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, 
                        T3.NumOfQuestions, T4.NumOfAnswers FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2009 
                        ORDER BY TotalScore DESC) AS T5 
            UNION 
            SELECT T5.Yearr, RANK() OVER(ORDER BY ((T5.NumOfComments * 1) + (T5.NumOfQuestions * 2) + (T5.NumOfAnswers *3)) DESC) AS Rankk, CONCAT(T5.DisplayName, ': ', 
            ((T5.NumOfComments * 1) + (T5.NumOfQuestions * 2) + (T5.NumOfAnswers *3))) AS Total FROM( 
                        SELECT TOP 3 ((T2.NumOfComments * 1) + (T3.NumOfQuestions * 2) + (T4.NumOfAnswers *3)) AS TotalScore, T2.Yearr, T2.UserId, T2.DisplayName, T2.NumOfComments, 
                        T3.NumOfQuestions, T4.NumOfAnswers FROM(( 
                                    SELECT COUNT(T1.Userid) AS NumOfComments, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT C.UserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, C.CreationDate) AS Yearr 
                                                  FROM dbo.Comments AS C INNER JOIN dbo.Users AS U ON C.UserId = U.Id) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T2 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfQuestions, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId, U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 1) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T3 
                                    ON T2.UserId = T3.UserId AND T2.Yearr = T3.Yearr) 
                        INNER JOIN( 
                                    SELECT COUNT(T1.UserId) AS NumOfAnswers, T1.UserId, T1.DisplayName, T1.Yearr 
                                    FROM (SELECT P.OwnerUserId AS UserId,U.DisplayName AS DisplayName, DATEPART(YYYY, P.CreationDate) AS Yearr 
                                                  FROM dbo.Posts AS P INNER JOIN dbo.Users AS U ON P.OwnerUserId = U.Id AND P.PostTypeId = 2) AS T1 
                                    GROUP BY T1.Yearr, T1.UserId, T1.DisplayName) AS T4 
                        ON T3.UserId = T4.UserId AND T3.Yearr = T4.Yearr 
                        WHERE T2.Yearr = 2010 
                        ORDER BY TotalScore DESC) AS T5) AS T9 
ON T8.Yearr = T9.Yearr AND T8.Rankk = T9.Rankk 
ORDER BY T6.Yearr ASC, T6.Rankk ASC
