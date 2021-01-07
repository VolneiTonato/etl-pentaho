SELECT X.cod_cliente
      ,X.cod_produto
      ,X.cod_organizacional
      ,X.cod_fabrica
      ,X.cod_tempo
      ,X.faturamento
      ,X.imposto
      ,X.custo_variavel
	  ,X.unidade_vendida
      ,X.quantidade_vendida
	  ,(X.quantidade_vendida/Y.quantidade_vendida_002) * Y.Custo_Frete AS Frete_Rateio
	  ,(X.quantidade_vendida/W.quantidade_vendida_003) * W.Custo_Fixo AS Custo_Fixo_Rateio
	  ,(X.quantidade_vendida/Z.quantidade_vendida_004) * Z.Meta_faturamento AS Meta_faturamento_Rateio
	  ,(X.quantidade_vendida/K.quantidade_vendida_005) * K.Meta_Custo AS Meta_Custo_Rateio
  FROM sw_sucos.Fato_001 X
  INNER JOIN (
SELECT A.cod_cliente
      ,A.cod_produto
      ,A.cod_fabrica
      ,A.cod_tempo
      ,A.Custo_Frete
	  , B.quantidade_vendida_002
  FROM sw_sucos.Fato_002 A
  INNER JOIN (
SELECT cod_cliente
      ,cod_produto
      ,cod_fabrica
      ,cod_tempo
      ,SUM(quantidade_vendida) AS quantidade_vendida_002
  FROM sw_sucos.Fato_001
  GROUP BY cod_cliente
      ,cod_produto
      ,cod_fabrica
      ,cod_tempo) B
	  ON A.cod_cliente = B.cod_cliente AND A.cod_produto = B.cod_produto
	  AND A.cod_fabrica = B.cod_fabrica AND A.cod_tempo = B.cod_tempo ) Y
	  ON X.cod_cliente = Y.cod_cliente AND X.cod_produto = Y.cod_produto
	  AND X.cod_fabrica = Y.cod_fabrica AND X.cod_tempo = Y.cod_tempo
INNER JOIN (
  SELECT A.cod_fabrica
      ,A.cod_tempo
      ,A.Custo_Fixo
	  , B.quantidade_vendida_003
  FROM sw_sucos.Fato_003 A
  INNER JOIN (
   SELECT cod_fabrica
      ,cod_tempo
      ,SUM(quantidade_vendida) AS quantidade_vendida_003
  FROM sw_sucos.Fato_001
  GROUP BY cod_fabrica
      ,cod_tempo) B
	  ON A.cod_fabrica = B.cod_fabrica AND A.cod_tempo = B.cod_tempo ) W
	  ON X.cod_fabrica = W.cod_fabrica AND X.cod_tempo = W.cod_tempo
inner join (
	  SELECT A.cod_cliente
      ,A.cod_produto
      ,A.cod_organizacional
      ,A.cod_tempo
      ,A.Meta_faturamento
	  ,B.quantidade_vendida_004
  FROM sw_sucos.Fato_004 A
  INNER JOIN (
  	  SELECT cod_cliente
      ,cod_produto
      ,cod_organizacional
      ,cod_tempo
      ,SUM(quantidade_vendida) AS quantidade_vendida_004
  FROM sw_sucos.Fato_001
  GROUP BY cod_cliente
      ,cod_produto
      ,cod_organizacional
      ,cod_tempo) B ON 
   A.cod_cliente = B.cod_cliente AND A.cod_produto = B.cod_produto
	  AND A.cod_tempo = B.cod_tempo ) Z
	  ON X.cod_cliente = Z.cod_cliente AND X.cod_produto = Z.cod_produto
	  AND X.cod_tempo = Z.cod_tempo
INNER JOIN (
	  SELECT A.cod_produto
      ,A.cod_fabrica
      ,A.cod_tempo
      ,A.Meta_Custo
	  ,B.quantidade_vendida_005
  FROM sw_sucos.Fato_005 A
  INNER JOIN (
	  SELECT cod_produto
      ,cod_fabrica
      ,cod_tempo
      ,SUM(quantidade_vendida) AS quantidade_vendida_005
  FROM sw_sucos.Fato_001
  GROUP BY cod_produto
      ,cod_fabrica
      ,cod_tempo) B
	  ON 	A.cod_produto = B.cod_produto
	  AND A.cod_fabrica = B.cod_fabrica AND A.cod_tempo = B.cod_tempo ) K
ON X.cod_produto = K.cod_produto
	  AND X.cod_fabrica = K.cod_fabrica AND X.cod_tempo = K.cod_tempo
	  WHERE CAST(SUBSTRING(X.cod_tempo,1,4) AS UNSIGNED) >= 2013 
	  AND CAST(SUBSTRING(X.cod_tempo,5,2) AS UNSIGNED) >= 1
	  AND CAST(SUBSTRING(X.cod_tempo,1,4) AS UNSIGNED) <= 2013 
	  AND CAST(SUBSTRING(X.cod_tempo,5,2) AS UNSIGNED) <= 1