
CREATE TABLE public.dim_barco (
                sk_barco INTEGER NOT NULL,
                nk_nome_barco VARCHAR(50) NOT NULL,
                tipo VARCHAR(10) NOT NULL,
                comprimento REAL NOT NULL,
                calado REAL NOT NULL,
                largura REAL NOT NULL,
                classe_dp VARCHAR NOT NULL,
                CONSTRAINT sk_barco PRIMARY KEY (sk_barco)
);
COMMENT ON COLUMN public.dim_barco.sk_barco IS 'SK -barco';
COMMENT ON COLUMN public.dim_barco.nk_nome_barco IS 'Nome da embarca��o fict�cio';
COMMENT ON COLUMN public.dim_barco.tipo IS 'Tipos:
RSV (Remotely Support Vessel): Embarca��es equipadas com ve�culos de opera��o remota (Remotely Operated Vehicle - ROV).

RV (Research Vessel): Embarca��es de Pesquisa.

DSV (Diving Support Vessel):Embarca��es para suporte e apoio ao mergulho.

PLSV (Pipe Laying Support Vessel): Embarca��o complexa e altamente especializada, dotada de equipamentos/sistemas sofisticados e de elevado valor, � usada para constru��o e lan�amento de linhas r�gidas e flex�veis.

AHTS (Anchor Handling and Tug Supply):Embarca��es de elevada pot�ncia que atuam como rebocador, manuseio de �ncoras e transporte de suprimentos.';
COMMENT ON COLUMN public.dim_barco.classe_dp IS 'Relativo a classe do sistema de posicionamento da embarca��o';


CREATE SEQUENCE public.dim_tempo_sk_tempo_seq;

CREATE TABLE public.dim_tempo (
                sk_tempo INTEGER NOT NULL DEFAULT nextval('public.dim_tempo_sk_tempo_seq'),
                nk_data DATE NOT NULL,
                dia INTEGER NOT NULL,
                mes INTEGER NOT NULL,
                ano INTEGER NOT NULL,
                CONSTRAINT sk_tempo PRIMARY KEY (sk_tempo)
);


ALTER SEQUENCE public.dim_tempo_sk_tempo_seq OWNED BY public.dim_tempo.sk_tempo;

CREATE SEQUENCE public.ft_registro_parada_sk_ft_parada_seq;

CREATE TABLE public.ft_registro_parada (
                sk_ft_parada INTEGER NOT NULL DEFAULT nextval('public.ft_registro_parada_sk_ft_parada_seq'),
                sk_barco INTEGER NOT NULL,
                sk_tempo INTEGER NOT NULL,
                duracao REAL NOT NULL,
                motivo VARCHAR(50) NOT NULL,
                manuntencao_dp VARCHAR(5),
                potencia_propulsor1 VARCHAR(20),
                potencia_propulsor2 VARCHAR(20),
                potencia_propulsor3 VARCHAR(20),
                potencia_propoulsor4 VARCHAR(20),
                onda_altura REAL,
                vento_velocidade REAL,
                corrente_velocidade REAL,
                CONSTRAINT sk_parada PRIMARY KEY (sk_ft_parada, sk_barco, sk_tempo)
);
COMMENT ON COLUMN public.ft_registro_parada.duracao IS 'Dura��o em horas da parada';
COMMENT ON COLUMN public.ft_registro_parada.motivo IS 'Motivo da parada';
COMMENT ON COLUMN public.ft_registro_parada.manuntencao_dp IS 'Indica��o se o sistema DP conseguiu ser mantido';
COMMENT ON COLUMN public.ft_registro_parada.potencia_propulsor1 IS 'Faixa de pot�ncia do propulsor 1 do sistema DP';
COMMENT ON COLUMN public.ft_registro_parada.potencia_propulsor2 IS 'Faixa de pot�ncia do propulsor 2 do sistema DP';
COMMENT ON COLUMN public.ft_registro_parada.potencia_propulsor3 IS 'Faixa de pot�ncia do propulsor 3 do sistema DP';
COMMENT ON COLUMN public.ft_registro_parada.potencia_propoulsor4 IS 'Faixa de pot�ncia do propulsor 4 do sistema DP';
COMMENT ON COLUMN public.ft_registro_parada.onda_altura IS 'HS- Altura Significativa de onda em metros';
COMMENT ON COLUMN public.ft_registro_parada.vento_velocidade IS 'Velocidade do vento em n�s';
COMMENT ON COLUMN public.ft_registro_parada.corrente_velocidade IS 'Velocidade da corrente de superf�cie em n�s';


ALTER SEQUENCE public.ft_registro_parada_sk_ft_parada_seq OWNED BY public.ft_registro_parada.sk_ft_parada;

ALTER TABLE public.ft_registro_parada ADD CONSTRAINT dim_barco_ft_parada_fk
FOREIGN KEY (sk_barco)
REFERENCES public.dim_barco (sk_barco)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ft_registro_parada ADD CONSTRAINT dim_tempo_ft_parada_fk
FOREIGN KEY (sk_tempo)
REFERENCES public.dim_tempo (sk_tempo)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
