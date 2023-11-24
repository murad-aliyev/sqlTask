CREATE DATABASE Library;

USE Library

CREATE TABLE Books
(
	id int identity Primary Key,
	Name nvarchar(100) CHECK (LEN(Name) >= 2 AND LEN(Name) <= 100),
	PageCount int CHECK (PageCount>=10),
	AuthorId int,
	FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
)


CREATE TABLE Authors
(
	id int identity Primary Key,
	Name nvarchar(255),
	SurName nvarchar(255)
)

INSERT INTO Authors
VALUES
(N'Viktor',N'Hüqo'),
(N'Fyodr',N'Dostoyevski'),
(N'Corc',N'Ourell'),
(N'Con Ronald',N'Tolkien'),
(N'Nizami',N'G?nc?vi')


INSERT INTO Books
VALUES
(N'S?fill?r', 1462, 1),
(N'Qumarbaz', 354, 2),
(N'Birma Günl?ri', 158, 3),
(N'Üzükl?rin ?f?ndisi', 1600, 4),
(N'Yeddi Göz?l', 900, 5),
(N'Tom Soyerin Ma?ralarl', 267, 1)



Create View usv_GetBooksInfo
as
Select Books.id, Books.Name, Books.PageCount, CONCAT (Authors.Name, ' ', Authors.SurName) as  AuthorFullName From Books
join Authors
on Books.AuthorId = Authors.id


Select * From usv_GetBooksInfo



Create Procedure usp_GetBookBySearch
@search nvarchar(255)
as
begin
	Select Books.id, Books.Name, Books.PageCount, CONCAT (Authors.Name, ' ', Authors.SurName) as  AuthorFullName From Books 
	join Authors
	on Books.AuthorId = Authors.id where (Authors.Name LIKE concat('%', @search,'%') OR Authors.SurName LIKE concat('%', @search,'%'))
end

exec usp_GetBookBySearch 'Dostoyevski'




CREATE PROCEDURE usp_InsertAuthor
    @name NVARCHAR(255),
    @surname NVARCHAR(255)
AS
BEGIN
    INSERT INTO Authors (Name, Surname)
    VALUES (@name, @surname);
END;

EXEC usp_InsertAuthor 'J.K.', 'Rowling';




CREATE PROCEDURE usp_UpdateAuthor
    @id INT,
    @name NVARCHAR(255),
    @surname NVARCHAR(255)
AS
BEGIN
    UPDATE Authors
    SET Name = @name, Surname = @surname
    WHERE Id = @id;
END;

EXEC usp_UpdateAuthor 1, 'Victor', 'Hugo';





CREATE PROCEDURE usp_DeleteAuthor
    @id INT
AS
BEGIN
    DELETE FROM Books WHERE AuthorId = @id;
    DELETE FROM Authors WHERE Id = @id;
END;

EXEC usp_DeleteAuthor 3;





CREATE VIEW usv_AuthorsInfo AS
SELECT
    a.Id,
    CONCAT(a.Name, ' ', a.Surname) AS FullName,
    COUNT(b.Id) AS BooksCount,
    SUM(b.PageCount) AS OverallPageCount
FROM Authors a
LEFT JOIN Books b ON a.Id = b.AuthorId
GROUP BY a.Id, a.Name, a.Surname;


SELECT * FROM usv_AuthorsInfo;
