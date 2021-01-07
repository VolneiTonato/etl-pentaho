SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY {[Tempo.Calendario].[2018], [Tempo.Calendario].[2019]} ON ROWS
FROM [dmpresidencia]
WHERE {[Fabrica].[001]}


SELECT 
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY {[Tempo.Calendario].[Todos].Children} ON ROWS
FROM 
[dmpresidencia]



SELECT 
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY {[Tempo.Calendario].[2018], [Tempo.Calendario].[2019]} ON ROWS
FROM 
[dmpresidencia]
WHERE {[Fabrica].[001]}




SELECT 
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY {
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro],
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Fevereiro],
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Março]
} ON ROWS
FROM 
[dmpresidencia]
WHERE {[Fabrica].[001]}


SELECT 
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY {
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro]:[Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Março]
} ON ROWS
FROM 
[dmpresidencia]
WHERE {[Fabrica].[001]}


SELECT 
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY {
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro]:[Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Março],
    [Tempo.Calendario].[2018].[Segundo Semestre].[Terceiro Trimestre].[Julho]:[Tempo.Calendario].[2018].[Segundo Semestre].[Terceiro Trimestre].[Setembro]
} ON ROWS
FROM 
[dmpresidencia]
WHERE {[Fabrica].[001]}


SELECT 
NON EMPTY {[Fabrica].Children} ON COLUMNS,
NON EMPTY {[Produto].[Marca].members} ON ROWS
FROM 
[dmpresidencia]
where {[Measures].[Faturamento]}



SELECT 
NON EMPTY {[Fabrica].Children} ON COLUMNS,
{[Produto].[Mate].[Frescor do Verão]:[Produto].[Suco de Frutas].[Pedaços de Frutas]} ON ROWS
FROM 
[dmpresidencia]
where {[Measures].[Faturamento]}



--listar apenas um produto de uma marca. Marca "Aguas Minerais" e Produto Linha Citros

SELECT 
NON EMPTY {[Fabrica].Children} ON COLUMNS,
NON EMPTY {[Produto].[Águas Minerais].[Linha Citros]} ON ROWS
FROM 
[dmpresidencia]
where {[Measures].[Faturamento]}


--listar todos os produtos de uma marca com children

SELECT 
NON EMPTY {[Fabrica].Children} ON COLUMNS,
NON EMPTY {[Produto].[Águas Minerais].[Linha Citros].children} ON ROWS
FROM 
[dmpresidencia]
where {[Measures].[Faturamento]}


-- CrossJoin para mostrar mais de uma dimensão
-- CrossJoin só aceita 2 parametros

SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY CrossJoin({[Cliente].[Regiao].Members}, {[Produto].[Categoria].Members}) ON ROWS
FROM
[dmpresidencia]


SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY CrossJoin({
    [Fabrica].Members}, 
    crossJoin({[Cliente].[Regiao].Members}, {[Produto].[Categoria].Members})
) ON ROWS
FROM
[dmpresidencia]


SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} ON COLUMNS,
NON EMPTY CrossJoin({
    [Fabrica].Members}, 
    crossJoin({[Cliente].[Regiao].Members}, {[Produto].[Produto].Members})
) ON ROWS
FROM
[dmpresidencia]



--HIERARCHIZE
--Segue a ordem alfabética dentro da sua hierarchia interna do cubo

SELECT
NON EMPTY {[Measures].[Faturamento]} ON COLUMNS,
Hierarchize 
({[Cliente].[Sudeste].[RJ]
, [Cliente].[Sudeste].[SP]
, [Cliente].[Centro Oeste].[DF]
, [Cliente].[Sul].[RS]}) ON ROWS
FROM [dmpresidencia]


--- EMPLO SEM HIERARCHIZE

SELECT
NON EMPTY {[Measures].[Faturamento]} ON COLUMNS,
NON EMPTY (
{[Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Março]
, [Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].[Dezembro]
, [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro]}) ON ROWS
FROM [dmpresidencia]

-- COM HIERARCHIZE

SELECT
NON EMPTY {[Measures].[Faturamento]} ON COLUMNS,
NON EMPTY HIERARCHIZE(
{[Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Março]
, [Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].[Dezembro]
, [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro]}) ON ROWS
FROM [dmpresidencia]



-- order
-- PODE SER USADO O TERCEIRO PARAMETRO (ASC, DESC, BDESC E BASC)
SELECT 
NON EMPTY {[Measures].[Faturamento], [Measures].[Margem]} on columns,
NON EMPTY ORDER({
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Março],
    [Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].[Dezembro],
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro]

}, [Measures].[Faturamento], ASC) ON rows
from [dmpresidencia]


SELECT
NON EMPTY {[Measures].[Faturamento]} ON COLUMNS,
NON EMPTY ORDER({Crossjoin({[Tempo.Calendario].[2019].[Primeiro Semestre].[Primeiro Trimestre].[Março],
 [Tempo.Calendario].[2019].[Segundo Semestre].[Quarto Trimestre].[Dezembro],
 [Tempo.Calendario].[2019].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro]},
	{[Produto].[Marca].Members})}, [Measures].[Faturamento], basc) ON ROWS
FROM [dmpresidencia]


--filter
-- precisa de uma condição e normalmente usa-se dentro um order:
-- ex: Quero os 10 maiores valores de faturamento

SELECT
NON EMPTY {[Measures].[Faturamento]} ON COLUMNS,
NON EMPTY Filter( Order(  Crossjoin({[Tempo.Calendario].[2019].[Primeiro Semestre].[Primeiro Trimestre].[Mar�o],
 [Tempo.Calendario].[2019].[Segundo Semestre].[Quarto Trimestre].[Dezembro],
 [Tempo.Calendario].[2019].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro]},
	{[Produto].[Marca].Members}), [Measures].[Faturamento], BDESC), 
[Measures].[Faturamento] > 1000000) ON ROWS
FROM [dmpresidencia]


-- With
-- format string = "#,###.00", "$ #,###.##", "#,###.00 %", etc...
-- VEM SEMPRE ANTES DO SELECT E SÃO MEDIDAS CRIADAS EM TEMPO DE EXECUÇÃO


WITH MEMBER [Measures].[Percentual Venda Liquida]
AS
'([Measures].[Faturamento Liquido] / [Measures].[Faturamento])*100'
SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[Faturmanto Liquido], [Measures].[Percentual Venda Liquida]} on columns,
NON EMPTY {[Tempo.Calendario].[Mes].Members} on rows
FROM [dmpresidencia]

--
-- COM O FORMAT NÃO PRECISA MULTIPLICAR POR 100

WITH MEMBER [Measures].[Percentual Venda Liquida]
AS
'([Measures].[Faturamento Liquido] / [Measures].[Faturamento])', FORMAT_STRING = "#,###.00 %"
SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[Faturmanto Liquido], [Measures].[Percentual Venda Liquida]} on columns,
NON EMPTY {[Tempo.Calendario].[Mes].Members} on rows
FROM [dmpresidencia]



---


WITH MEMBER [Measures].[Diferenca Faturamento Liquido]
AS
'([Measures].[Faturamento] - [Measures].[Faturamento Liquido])'
MEMBER [Measures].[Percentual Venda Liquida]
AS
'([Measures].[Faturamento Liquido] / [Measures].[Faturamento])', FORMAT_STRING = "#,###.00 %"
SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[Faturmanto Liquido], [Measures].[Percentual Venda Liquida], [Measures].[Diferenca Faturamento Liquido]} on columns,
NON EMPTY {[Tempo.Calendario].[Mes].Members} on rows
FROM [dmpresidencia]


----

WITH MEMBER [Tempo.Calendario].[Variacao Favereiro X Janeiro]
AS
'([Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Fevereiro] / 
 [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro])', FORMAT_STRING = "#,###.00 %"
SELECT
NON EMPTY {[Measures].[Faturamento]} on ROWS,
NON EMPTY {
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Janeiro],
    [Tempo.Calendario].[2018].[Primeiro Semestre].[Primeiro Trimestre].[Fevereiro],
    [Tempo.Calendario].[Variacao Favereiro X Janeiro]
} on COLUMNS
FROM [dmpresidencia]




----


WITH MEMBER [Measures].[Status]
AS
'iif([Measures].[Faturamento] >= 800000, "TOP", "LOW")'
SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[Status]} on COLUMNS,
NON EMPTY CROSSJOIN({[Tempo.Calendario].[Mes].Members}, CROSSJOIN({[Produto].[Marca].Members}, {[Cliente].[Regiao].Members})) on ROWS
FROM [dmpresidencia]


-- sum
WITH MEMBER [Tempo.Calendario].[Soma Outubro - Dezembro] 
AS 'SUM (( {[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children}) , [Measures].[Faturamento])'
SELECT
[Measures].[Faturamento] ON COLUMNS,
{[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children,[Tempo.Calendario].[Soma Outubro - Dezembro] } ON ROWS
FROM [dmpresidencia]

-- avg 
WITH MEMBER [Tempo.Calendario].[Média Outubro - Dezembro] 
AS 'AVG (( {[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children}) , [Measures].[Faturamento])'
SELECT
[Measures].[Faturamento] ON COLUMNS,
{[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children,[Tempo.Calendario].[Média Outubro - Dezembro] } ON ROWS
FROM [dmpresidencia]

WITH MEMBER [Tempo.Calendario].[Mínimo Outubro - Dezembro] 
AS 'MIN (( {[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children}) , [Measures].[Faturamento])'
SELECT
[Measures].[Faturamento] ON COLUMNS,
{[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children,[Tempo.Calendario].[Mínimo Outubro - Dezembro] } ON ROWS
FROM [dmpresidencia]


WITH MEMBER [Tempo.Calendario].[Desvio Outubro - Dezembro] 
AS 'STDEV (( {[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children}) , [Measures].[Faturamento])'
MEMBER [Tempo.Calendario].[Desvio Padrão Outubro - Dezembro] 
AS 'STDEVP (( {[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children}) , [Measures].[Faturamento])'
MEMBER [Tempo.Calendario].[Variancia Outubro - Dezembro] 
AS 'VAR (( {[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children}) , [Measures].[Faturamento])'
MEMBER [Tempo.Calendario].[Variancia Padrão Outubro - Dezembro] 
AS 'VARP (( {[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children}) , [Measures].[Faturamento])'
SELECT
[Measures].[Faturamento] ON COLUMNS,
{[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children
,[Tempo.Calendario].[Desvio Outubro - Dezembro]
,[Tempo.Calendario].[Desvio Padrão Outubro - Dezembro]
,[Tempo.Calendario].[Variancia Outubro - Dezembro] 
,[Tempo.Calendario].[Variancia Padrão Outubro - Dezembro]  } ON ROWS
FROM [dmpresidencia]

-----

WITH MEMBER [Produto].[Minimo]
AS
'MIN({[Produto].[Categoria].Members}, [Measures].[Faturamento])'

SELECT
{[Produto].[Minimo]} ON ROWS,
[Measures].[Faturamento] ON COLUMNS
FROM [dmpresidencia]
where [Tempo.Calendario].[2018]



--- SET NAME

WITH SET [Quarto Trimestre 2018]
AS
'[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children'

SELECT
[Measures].[Faturamento] ON COLUMNS,
{[Quarto Trimestre 2018]} on rows
FROM [dmpresidencia]


WITH SET [Todas Marcas]
AS
'[Produto].[Marca].Members'

SELECT
[Measures].[Faturamento] ON COLUMNS,
{[Todas Marcas]} on rows
FROM [dmpresidencia]


-- exists

SELECT
NON EMPTY {[Measures].[Faturamento]} ON COLUMNS,
NON EMPTY 
EXISTS({[Tempo.Calendario].[Mes].Members}, [Tempo.Calendario].[2018]) ON ROWS
FROM [dmpresidencia]


--- andando nas dimensões

WITH MEMBER [Measures].[% TAXA] AS
'[Measures].[Faturamento]/
([Measures].[Faturamento], 
[Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre])'
, FORMAT_STRING = "#,###.00 %"
Select  Non Empty  
{ [Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre].Children, [Tempo.Calendario].[2018].[Segundo Semestre].[Quarto Trimestre]}  On Rows  ,  
Non Empty  { [Measures].[Faturamento], [Measures].[% TAXA] }  On Columns 
FROM [dmpresidencia]

WITH MEMBER [Measures].[Participacao] AS
' [Measures].[Faturamento] /
( [Measures].[Faturamento], [Fabrica].[Fabrica].Currentmember.Parent )'
, FORMAT_STRING = '#,###.## %'
SELECT NON EMPTY
({[Fabrica].[Fabrica].Members}) on Rows,
({[Measures].[Faturamento], [Measures].[Participacao] }) on Columns from [dmpresidencia]


------

WITH 
MEMBER [Measures].[FATURAMENTO 2019] AS
'([Measures].[Faturamento])', FORMAT_STRING = "#,###.00"
MEMBER [Measures].[FATURAMENTO 2018] AS
'([Measures].[Faturamento], 
ParallelPeriod ([Tempo.Calendario].[Ano], -1, [Tempo.Calendario].CurrentMember))'
, FORMAT_STRING = "#,###.00"
MEMBER [Measures].[VARIAÇAO] AS
'([Measures].[FATURAMENTO 2019]/[Measures].[FATURAMENTO 2018])-1', FORMAT_STRING = "#,###.00 %"
MEMBER [Measures].[FATURAMENTO 2020] AS
'([Measures].[Faturamento], 
ParallelPeriod ([Tempo.Calendario].[Ano], 1, [Tempo.Calendario].CurrentMember))'
, FORMAT_STRING = "#,###.00"
Select  Non Empty  
Exists({ [Tempo.Calendario].[Mes].Members },[Tempo.Calendario].[2019]) On Rows  ,  
Non Empty  { [Measures].[FATURAMENTO 2019], [Measures].[FATURAMENTO 2018], [Measures].[FATURAMENTO 2020], [Measures].[VARIAÇAO]}  On Columns 
FROM [dmpresidencia]




WITH
SET [~FILTER] AS
    {[Tempo.Calendario].[Ano].Members}
SET [~ROWS] AS
    {[Produto].[Produto].Members}
MEMBER [Measures].[ANO ANTERIOR] 
AS
'([Measures].[Faturamento], ParallelPeriod([Tempo.Calendario].[Ano], -1, [Tempo.Calendario].CurrentMember))'
, FORMAT_STRING = "#,###.00"
SELECT
NON EMPTY {[Measures].[Faturamento], [Measures].[ANO ANTERIOR]} ON COLUMNS,
NON EMPTY [~ROWS] ON ROWS
FROM [dmpresidencia]
WHERE [~FILTER]