--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auditlogs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auditlogs (
    log_id integer NOT NULL,
    action text NOT NULL,
    user_id integer,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.auditlogs OWNER TO postgres;

--
-- Name: auditlogs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auditlogs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auditlogs_log_id_seq OWNER TO postgres;

--
-- Name: auditlogs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auditlogs_log_id_seq OWNED BY public.auditlogs.log_id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cache (
    cache_key character varying(255) NOT NULL,
    cache_value text,
    expiration_time timestamp without time zone NOT NULL
);


ALTER TABLE public.cache OWNER TO postgres;

--
-- Name: cartitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cartitems (
    cart_item_id integer NOT NULL,
    cart_id integer,
    product_id integer,
    quantity integer NOT NULL
);


ALTER TABLE public.cartitems OWNER TO postgres;

--
-- Name: cartitems_cart_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cartitems_cart_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cartitems_cart_item_id_seq OWNER TO postgres;

--
-- Name: cartitems_cart_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cartitems_cart_item_id_seq OWNED BY public.cartitems.cart_item_id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: orderitems; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orderitems (
    order_item_id integer NOT NULL,
    order_id integer,
    product_id integer,
    quantity integer NOT NULL,
    price numeric(10,2) NOT NULL
);


ALTER TABLE public.orderitems OWNER TO postgres;

--
-- Name: orderitems_order_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orderitems_order_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orderitems_order_item_id_seq OWNER TO postgres;

--
-- Name: orderitems_order_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orderitems_order_item_id_seq OWNED BY public.orderitems.order_item_id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.orders (
    order_id integer NOT NULL,
    user_id integer,
    order_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(50) NOT NULL,
    total_amount numeric(10,2) NOT NULL
);


ALTER TABLE public.orders OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.orders_order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.orders_order_id_seq OWNER TO postgres;

--
-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.orders_order_id_seq OWNED BY public.orders.order_id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    order_id integer,
    amount numeric(10,2) NOT NULL,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    payment_method character varying(50) NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.payments_payment_id_seq OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: productimages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productimages (
    image_id integer NOT NULL,
    product_id integer,
    image_url text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.productimages OWNER TO postgres;

--
-- Name: productimages_image_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productimages_image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.productimages_image_id_seq OWNER TO postgres;

--
-- Name: productimages_image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productimages_image_id_seq OWNED BY public.productimages.image_id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    product_id integer NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    stock integer DEFAULT 0,
    category_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    seller_id integer
);


ALTER TABLE public.products OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.products_product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.products_product_id_seq OWNER TO postgres;

--
-- Name: products_product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.products_product_id_seq OWNED BY public.products.product_id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reviews (
    review_id integer NOT NULL,
    product_id integer,
    user_id integer,
    rating integer,
    comment text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reviews_rating_check CHECK (((rating >= 1) AND (rating <= 5)))
);


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_review_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.reviews_review_id_seq OWNER TO postgres;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    role_id integer NOT NULL,
    role_name character varying(50) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_role_id_seq OWNER TO postgres;

--
-- Name: roles_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_role_id_seq OWNED BY public.roles.role_id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    session_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expires_at timestamp without time zone NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: sessions_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sessions_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sessions_session_id_seq OWNER TO postgres;

--
-- Name: sessions_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sessions_session_id_seq OWNED BY public.sessions.session_id;


--
-- Name: shoppingcart; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shoppingcart (
    cart_id integer NOT NULL,
    user_id integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.shoppingcart OWNER TO postgres;

--
-- Name: shoppingcart_cart_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shoppingcart_cart_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.shoppingcart_cart_id_seq OWNER TO postgres;

--
-- Name: shoppingcart_cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shoppingcart_cart_id_seq OWNED BY public.shoppingcart.cart_id;


--
-- Name: useraddresses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.useraddresses (
    address_id integer NOT NULL,
    user_id integer,
    street character varying(255),
    city character varying(100),
    state character varying(100),
    zip_code character varying(20)
);


ALTER TABLE public.useraddresses OWNER TO postgres;

--
-- Name: useraddresses_address_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.useraddresses_address_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.useraddresses_address_id_seq OWNER TO postgres;

--
-- Name: useraddresses_address_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.useraddresses_address_id_seq OWNED BY public.useraddresses.address_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(255) NOT NULL,
    email character varying(100) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    role integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: auditlogs log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditlogs ALTER COLUMN log_id SET DEFAULT nextval('public.auditlogs_log_id_seq'::regclass);


--
-- Name: cartitems cart_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems ALTER COLUMN cart_item_id SET DEFAULT nextval('public.cartitems_cart_item_id_seq'::regclass);


--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: orderitems order_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderitems ALTER COLUMN order_item_id SET DEFAULT nextval('public.orderitems_order_item_id_seq'::regclass);


--
-- Name: orders order_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders ALTER COLUMN order_id SET DEFAULT nextval('public.orders_order_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: productimages image_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productimages ALTER COLUMN image_id SET DEFAULT nextval('public.productimages_image_id_seq'::regclass);


--
-- Name: products product_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products ALTER COLUMN product_id SET DEFAULT nextval('public.products_product_id_seq'::regclass);


--
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- Name: roles role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN role_id SET DEFAULT nextval('public.roles_role_id_seq'::regclass);


--
-- Name: sessions session_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions ALTER COLUMN session_id SET DEFAULT nextval('public.sessions_session_id_seq'::regclass);


--
-- Name: shoppingcart cart_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcart ALTER COLUMN cart_id SET DEFAULT nextval('public.shoppingcart_cart_id_seq'::regclass);


--
-- Name: useraddresses address_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraddresses ALTER COLUMN address_id SET DEFAULT nextval('public.useraddresses_address_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: auditlogs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.auditlogs (log_id, action, user_id, "timestamp") FROM stdin;
1	Nisi qui se dicant in Graecis legendis operam malle consumere. Postremo aliquos futuros suspicor, qui me ad alias litteras vocent, genus hoc scribendi, etsi sit elegans, personae tamen et dignitatis esse negent. Contra quos omnis dicendum breviter existimo. Quamquam philosophiae quidem vituperatoribus satis responsum est eo libro, quo a populo Romano locatus.	91	2024-09-30 03:50:22
2	Deinde hoc quoque alienum; nam ante Aristippus, et ille melius. Addidisti ad extremum etiam indoctum fuisse. Fieri, inquam, Triari, nullo pacto potest, ut non modo fautrices fidelissimae, sed etiam cogitemus; infinitio ipsa, quam apeirian vocant, tota ab illo est, tum innumerabiles mundi.	5	2024-06-26 14:13:16
3	Itaque earum rerum defuturum, quas natura non depravata desiderat. Et quem ad me de virtute misisti. Sed ex eo est consecutus? -- Laudem et caritatem, quae sunt vitae sine metu degendae praesidia firmissima. -- Filium morte.	12	2024-10-17 12:15:11
4	His, qui rebus infinitis modum constituant in reque eo meliore, quo maior sit, mediocritatem desiderent. Sive.	16	2024-03-09 06:30:21
5	Cum memoriter, tum etiam erga nos.	82	2023-12-06 14:35:02
6	Voluptatibus, ut nulli propter eas consequantur.	7	2024-01-17 21:05:14
7	Qua quaeque res efficiatur, alterum, quae naturales essent nec tamen id, cuius.	18	2024-01-01 15:01:15
8	Tantas res gessisse sine causa? Quae fuerit causa, mox videro; interea hoc tenebo.	90	2024-01-16 12:04:56
9	Ut urbanitas summa appareat, doctrina mediocris. Ego autem quem timeam lectorem, cum ad te ne Graecis quidem cedentem in philosophia audeam scribere? Quamquam a te ipso id quidem facio provocatus gratissimo mihi libro, quem ad modum eae semper voluptatibus inhaererent, eadem de amicitia disputatum.	27	2024-09-13 17:29:50
10	Mihi illud dixeris: 'Haec enim ipsa.	57	2023-12-13 17:11:59
11	Numquam putavisset, si a Polyaeno, familiari suo, geometrica discere maluisset quam illum.	53	2024-10-13 22:28:54
12	Quid habent, cur Graeca anteponant iis, quae recordamur. Stulti autem malorum memoria torquentur, sapientes bona praeterita non meminerunt, praesentibus non fruuntur, futura modo expectant, quae quia certa esse non possunt et, si essent vera, nihil afferrent, quo iucundius, id est.	42	2024-09-26 18:36:35
13	Sed ipsius honestatis decore laudandis, id totum evertitur eo delectu rerum, quem modo dixi, constituto, ut aut voluptates omittantur maiorum voluptatum adipiscendarum causa aut dolores suscipiantur maiorum dolorum effugiendorum gratia. Sed de clarorum hominum factis illustribus.	48	2024-03-16 14:45:57
14	Nisi derigatur ad voluptatem, voluptas autem est sola, quae nos a libidinum impetu et a spe pariendarum voluptatum.	33	2024-02-26 07:48:53
15	Voluptatis. Itaque non placuit Epicuro medium esse quiddam inter dolorem.	54	2024-05-06 12:36:55
16	Sit, sublatum esse omne iudicium veri et falsi putat. Confirmat autem illud.	10	2024-05-31 09:39:42
17	Quam ostendis. Sed uti oratione perpetua malo quam interrogare aut interrogari. Ut placet, inquam. Tum dicere exorsus est. Primum igitur, inquit, sic agam, ut ipsi auctori huius disciplinae placet: constituam, quid et quale.	6	2024-04-20 22:10:08
18	Ad maiora enim quaedam nos natura genuit et conformavit, ut mihi quidem videtur, inermis ac.	82	2024-03-18 17:54:30
19	Maiores consequatur. Eadem fortitudinis ratio reperietur. Nam neque laborum perfunctio neque perpessio dolorum per.	58	2024-06-03 02:05:03
20	Ex futuris, sed expectat illa, fruitur praesentibus ab iisque M. Brutus dissentiet.	71	2023-12-25 23:21:06
21	Videtur multis voluptatibus, cum ipsi naturae patrioque amori praetulerit ius maiestatis atque imperii. Quid?	33	2023-12-09 08:37:21
22	Id est voluptatem. Homines optimi non intellegunt totam rationem everti, si ita res se habeat. Nam si ea sola voluptas esset, quae quasi titillaret sensus, ut ita ruant itaque turbent, ut earum motus et impetus quo pertineant non intellegamus, tu tam egregios.	84	2024-03-27 13:11:42
23	Nemo enim ipsam voluptatem, quia voluptas sit, aspernatur.	40	2024-09-12 04:46:44
24	Navigandi rationem habet, utilitate, non arte laudatur, sic.	87	2024-06-18 02:05:30
25	Voluptatem appetere eaque gaudere ut summo bono, dolorem aspernari ut summum ex rebus expetendis, quid fugiat ut extremum malorum? Qua de re cum sit.	19	2024-08-04 14:40:13
26	Bene vivendi recteque faciendi consilia referenda, quid sequatur natura ut summum ex rebus expetendis, quid fugiat ut extremum malorum? Qua de re cum sit inter doctissimos summa dissensio, quis alienum putet eius esse dignitatis, quam mihi quisque tribuat, quid in omni re doloris amotio successionem efficit voluptatis. Itaque non placuit Epicuro medium esse quiddam inter dolorem.	96	2024-03-19 13:06:28
27	Malorum memoria torquentur, sapientes bona praeterita grata recordatione renovata delectant. Est autem situm in nobis ut et adversa quasi perpetua oblivione obruamus et secunda iucunde ac suaviter meminerimus. Sed cum ea, quae dicta sunt ab iis.	66	2024-09-21 22:52:54
28	Loqui posset. Conclusum est enim contra Cyrenaicos satis acute, nihil ad iucunde vivendum reperiri posse, quod coniunctione tali sit aptius. Quibus ex omnibus iudicari potest non modo singulos homines, sed universas familias evertunt, totam etiam labefactant saepe rem publicam.	2	2023-12-12 03:04:31
30	Et molestiam dolor afferat, eorum tamen utrumque et ortum esse e corpore et ad dolores ita paratus est, ut omne, quo offendimur, dolor, doloris omnis privatio recte nominata est voluptas. Ut enim, cum cibo et potione fames sitisque depulsa est, ipsa detractio molestiae consecutionem.	89	2024-04-12 05:36:54
31	Ante hoc tempus numquam est nec cum istis.	98	2024-01-26 15:47:34
32	Continent, neglegentur? Nam, ut sint opera, studio, labore meo doctiores cives mei, nec cum iracundia aut pertinacia recte disputari potest. Sed ad haec, nisi.	33	2024-11-02 14:20:20
33	Laboribus, periculis non deseruisse mihi videor praesidium, in quo nihil nec summum nec infimum nec medium nec ultimum nec extremum.	38	2024-07-16 22:12:29
34	Oporteat, ipsum autem nusquam. Hoc Epicurus in voluptate aut in voluptate ponatur, sed sine hoc institutionem omnino amicitiae non posse reperiri. Quapropter si ea, quae dicta sunt ab iis quos probamus, eisque nostrum iudicium et nostrum scribendi ordinem adiungimus, quid.	12	2023-11-27 23:39:38
35	Summa voluptas est, ut omne, quo offendimur, dolor, doloris omnis privatio recte nominata est voluptas. Ut enim, cum cibo et potione fames sitisque depulsa est, ipsa detractio molestiae consecutionem affert voluptatis, sic in omni munere vitae optimum et verissimum sit, exquirere? An, partus ancillae sitne in fructu habendus, disseretur inter principes civitatis, P. Scaevolam M'.que Manilium.	89	2023-11-25 18:57:12
36	Assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et.	73	2024-02-20 12:05:56
77	Et percipi. Quos qui tollunt et nihil posse percipi dicunt, ii remotis sensibus ne id ipsum quidem expedire possunt, quod disserunt. Praeterea sublata cognitione.	93	2023-12-26 03:17:58
37	Recte, quae oblique ferantur, deinde eadem illa constituto veri a falso distinctio traditur. Restat locus huic disputationi vel maxime necessarius de amicitia, quam, si voluptas esset bonum, fuisse desideraturam. Idcirco enim non desideraret, quia, quod dolore caret, id in voluptate velit esse, quam nihil praetermittatur quod vitam adiuvet, quo facilius id, quod.	88	2024-10-09 05:17:40
38	Cum in rerum natura duo quaerenda sint, unum, quae materia sit, ex qua quaeque res.	32	2024-11-10 15:53:00
39	Quod ista Platonis, Aristoteli, Theophrasti orationis ornamenta neglexerit. Nam.	15	2024-03-16 22:10:06
40	Audita pronuntiaret eum non talem.	29	2024-04-06 10:02:05
41	Nisi dolorem, de quibus ante dictum est, sic amicitiam negant posse a voluptate aut a dolore.	61	2023-12-31 07:03:55
42	Sententiae; falli igitur possumus. Quam ob rem dissentientium inter se dissident atque discordant, ex quo intellegitur nec timiditatem ignaviamque vituperari nec fortitudinem patientiamque laudari suo nomine, sed illas.	93	2024-10-03 15:35:18
43	Iniuria detrimenti est quam in iis corrigere voluit, deteriora fecit. Disserendi artem nullam habuit. Voluptatem cum summum bonum diceret, primum in eo essent. Quae cum dixissem, magis ut illum provocarem quam ut ipse constituit, e regione ferrentur et, ut modo docui, cognitionis regula et iudicio ab eadem illa constituto veri a falso.	21	2024-10-07 22:38:13
44	Ut id apte fieri possit, ut ab ea nullo modo nec divelli nec distrahi possint, sic de iustitia.	72	2024-06-16 01:10:49
45	Et vituperata ab Hortensio. Qui liber cum et tibi probatus videretur et iis, quos ego posse.	100	2024-10-06 09:30:33
46	Liber cura et angore, cum et tibi.	8	2024-03-13 18:23:05
47	Et moribus comprobavit. Quod quam magnum sit fictae veterum fabulae declarant, in quibus sequitur Democritum, non fere labitur. Quamquam utriusque cum multa non probo, tum illud in primis.	37	2024-01-12 00:04:48
48	Ab ea nullo modo nec divelli nec distrahi possint, sic de iustitia iudicandum est, quae non modo non repugnantibus, verum etiam summam voluptatem. Quisquis enim sentit, quem ad modum affecta nunc est.	54	2024-03-03 00:35:37
49	Quod exiguam dixit fortunam intervenire sapienti maximasque ab eo et gravissimas res consilio ipsius et.	79	2024-06-28 14:07:12
50	Esse deditum dicitis; non posse iucunde vivi, nisi sapienter, honeste iusteque vivatur, nec sapienter, honeste, iuste, nisi iucunde.	6	2024-10-24 23:11:05
51	Sanciret militaris imperii disciplinam exercitumque in gravissimo bello animadversionis metu contineret, saluti prospexit civium, qua intellegebat contineri suam. Atque haec.	7	2024-02-02 04:18:45
52	Turpe est, ea putant usque ad senectutem esse discenda. Quae cum tota res (est) ficta pueriliter, tum ne efficit quidem.	77	2024-08-06 19:14:19
53	Quidem adduci vix possum, ut ea, quae senserit ille, tibi non vera.	20	2024-11-19 00:31:11
54	An 'Utinam ne in nemore . . .' nihilo minus legimus quam hoc idem Graecum, quae autem de bene beateque vivendo a Platone disputata sunt, haec explicari non.	86	2023-12-16 23:54:29
55	Nec cum istis tantopere pugnare, qui Graeca legere malint, modo legant illa ipsa, ne simulent, et iis quidem non admodum flagitem. Re mihi non aeque satisfacit, et quidem locis pluribus.	61	2024-04-02 09:20:57
56	Etiam cogitemus; infinitio ipsa, quam apeirian vocant, tota ab illo est, tum innumerabiles mundi, qui et oriantur et intereant cotidie.	64	2024-06-02 17:42:34
57	Referri, ut cum voluptate vivere. Nec enim habet nostra mens quicquam, ubi consistat tamquam.	61	2024-09-03 04:13:21
58	Amotio successionem efficit voluptatis. Itaque non placuit Epicuro medium esse quiddam inter dolorem et voluptatem; illud enim ipsum, quod quibusdam medium videretur, cum omni.	24	2023-12-09 14:59:16
59	Inutile, nosque ea scripta reliquaque eiusdem generis et legimus libenter et legemus --, haec, quae de philosophia litteris mandamus, legere assueverit, iudicabit nulla ad.	7	2024-08-27 00:15:16
60	In varias reprehensiones incurreret. Nam quibusdam, et iis servire, qui vel utrisque litteris uti.	39	2024-01-30 18:07:10
61	Signiferumque, maluisti dici. Graece ergo praetor Athenis, id quod maluisti, te, cum ad me.	32	2024-09-28 02:11:09
62	Theophrasti orationis ornamenta neglexerit. Nam illud quidem physici, credere aliquid esse minimum, quod profecto numquam putavisset, si a Polyaeno, familiari suo, geometrica discere maluisset quam illum etiam ipsum dedocere. Sol Democrito magnus videtur, quippe homini erudito.	55	2024-03-23 21:36:43
63	Omnes veri erunt, ut Epicuri ratio docet, tum denique poterit aliquid cognosci et percipi. Quos qui tollunt et nihil posse percipi dicunt, ii remotis sensibus ne id ipsum quidem expedire possunt, quod disserunt. Praeterea sublata cognitione et scientia tollitur omnis ratio et vitae degendae et rerum gerendarum. Sic e physicis et fortitudo sumitur contra mortis timorem.	82	2024-07-04 11:16:20
64	Lucilius, apud quem praeclare Scaevola: Graecum.	33	2024-06-27 14:46:10
65	Habent, illas non magnopere desiderent. Qui autem ita.	32	2024-07-09 12:47:45
66	Aliquam quaerat voluptatem. Ut enim mortis metu omnis quietae vitae status perturbatur, et ut succumbere doloribus eosque humili animo inbecilloque ferre miserum est, ob eamque debilitatem animi multi parentes, multi amicos, non nulli patriam, plerique autem se ipsos penitus perdiderunt, sic robustus animus et excelsus omni est liber cura et angore, cum et mortem contemnit, qua.	4	2024-06-29 19:19:03
67	Erudito in geometriaque perfecto, huic pedalis.	88	2024-02-13 11:14:03
68	Anteponant iis, quae recordamur. Stulti autem malorum memoria torquentur, sapientes bona praeterita non meminerunt, praesentibus non fruuntur, futura modo expectant, quae quia certa esse non possunt et, si essent vera, nihil afferrent, quo iucundius, id est.	10	2023-12-14 07:41:52
69	Amarissimam necesse est effici, ut sapiens solum amputata circumcisaque inanitate omni et errore naturae finibus contentus.	33	2024-04-09 14:51:39
70	Sabinum, municipem Ponti, Tritani, centurionum, praeclarorum hominum ac primorum signiferumque, maluisti dici. Graece ergo praetor Athenis, id quod.	20	2024-06-05 17:34:12
71	Facillimis ordiamur, prima veniat in medium Epicuri ratio, quae plerisque notissima est. Quam a nobis sic intelleges eitam.	6	2024-07-18 20:10:07
72	Igitur, inquit, sic agam, ut ipsi auctori huius disciplinae placet: constituam, quid et quale sit id, de quo Lucilius: 'ferreum scriptorem', verum, opinor, scriptorem tamen, ut legendus.	29	2024-09-14 16:29:21
73	Voluptate esse aut in poetis evolvendis, ut ego et Triarius te hortatore facimus, consumeret, in quibus hoc primum est in Ceramico Chrysippi sedentis porrecta manu, quae manus.	59	2024-03-19 05:34:28
74	Dolorem? Sunt autem quidam Epicurei timidiores paulo contra vestra convicia, sed tamen satis acuti.	6	2024-03-15 11:44:42
75	Neque homini infanti aut inpotenti iniuste facta conducunt, qui nec facile efficere.	56	2023-12-02 11:15:38
76	Videntur leviora, veniamus. Quid tibi, Torquate, quid huic Triario litterae, quid historiae.	57	2024-10-06 12:57:10
78	Intervenire sapienti maximasque ab eo dissentiunt, sed certe non probes, eum quem ego arbitror unum vidisse verum maximisque erroribus animos hominum liberavisse et omnia.	72	2024-03-17 00:30:36
79	Veritus ne movere hominum studia viderer, retinere non posse. Qui autem, si maxime hoc placeat.	57	2024-01-30 00:39:20
80	Epicurus neque Metrodorus aut quisquam eorum, qui aut saperet aliquid aut ista didicisset. Et quod adest sentire possumus, animo autem et praeterita grate meminit et praesentibus ita potitur, ut animadvertat quanta sint ea quamque iucunda, neque.	12	2023-12-10 16:04:56
81	Ita ferri, ut concursionibus inter se reprehensiones non sunt vituperandae, maledicta, contumeliae, tum iracundiae, contentiones concertationesque in disputando pertinaces indignae philosophia mihi videri solent.	94	2024-03-04 08:00:44
82	Alii petulantes, alii audaces, protervi, idem intemperantes et ignavi, numquam in sententia permanentes, quas ob causas in eorum.	24	2024-06-21 19:49:20
83	Suscipit, ut non plus habeat sapiens, quod gaudeat, quam quod angatur.	97	2023-12-10 07:43:55
84	Quo admirer, cur in gravissimis rebus non delectet eos sermo patrius, cum idem fabellas Latinas ad verbum e Graecis expressas non inviti legant. Quis enim tam inimicus paene nomini Romano est, qui.	63	2024-06-10 11:42:38
85	Facere ipsa per se esset et virtus.	1	2024-06-13 04:08:07
86	Intellegunt, errore maximo, si Epicurum audire voluerint, liberabuntur: istae enim.	37	2024-10-23 12:45:25
87	Omnis voluptas assumenda est, omnis.	60	2024-08-07 23:31:21
88	In voluptate ponatur, sed sine hoc institutionem omnino amicitiae non.	7	2024-06-12 19:35:57
89	Quibusdam usu venire; ut abhorreant a Latinis, quod inciderint in inculta quaedam et horrida.	44	2024-10-26 06:59:21
90	Graecis isdem de rebus alia ratione compositis, quid est, cur nostri a nostris non legantur? Quamquam, si plane sic verterem Platonem aut Aristotelem, ut verterunt nostri poetae fabulas, male, credo.	11	2024-02-14 03:41:29
91	In ipsis error est finibus bonorum et.	100	2024-07-05 19:17:53
92	Gratissimo mihi libro, quem ad modum affecta nunc est, desiderat?' -- Nihil sane. -- 'At.	63	2024-02-04 22:50:12
93	Statim consequi, nisi in voluptatis locum dolor forte successerit, at contra gaudere nosmet omittendis doloribus.	30	2023-11-23 02:49:26
94	Errata ab Epicuro sapiens semper beatus inducitur: finitas habet cupiditates, neglegit mortem, de diis inmortalibus sine ullo metu vera sentit, non dubitat, si ita melius sit, migrare de vita. His rebus peccant, cum e quibus haec efficiantur ignorant. Animi autem voluptates et dolores nasci.	69	2024-04-01 23:36:55
95	Ex infinito tempore aetatis percipi posse, quam ex hoc facillime perspici potest: Constituamus aliquem magnis, multis, perpetuis fruentem et animo et attento intuemur, tum fit ut aegritudo sequatur, si illa mala sint, laetitia.	34	2024-06-24 16:36:09
96	Ipsa esse contentam. Sed possunt haec quadam ratione dici non necesse est. Tribus igitur modis video esse a nostris non legantur?	91	2024-01-07 05:38:33
97	Iis corrigere voluit, deteriora fecit. Disserendi artem nullam habuit. Voluptatem cum summum.	68	2023-12-14 07:01:16
98	Sed sine hoc institutionem omnino amicitiae non modo non impediri rationem amicitiae, si summum bonum in voluptate ponit, quod summum bonum esse vult, summumque malum dolorem, idque instituit docere sic: Omne animal, simul atque natum sit, voluptatem appetere eaque gaudere.	16	2024-04-28 16:28:44
99	Propter eas consequantur dolores, et qui suum iudicium retinent, ne.	43	2023-12-28 23:14:26
100	Sunt tota Democriti, atomi, inane, imagines, quae eidola nominant, quorum incursione non solum videamus, sed etiam cogitemus; infinitio ipsa, quam apeirian vocant, tota ab illo inventore veritatis et.	63	2024-11-19 21:23:32
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cache (cache_key, cache_value, expiration_time) FROM stdin;
\.


--
-- Data for Name: cartitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cartitems (cart_item_id, cart_id, product_id, quantity) FROM stdin;
1	30	30	4
2	71	71	6
3	97	97	8
4	89	89	7
5	14	14	1
6	6	6	2
7	46	46	7
8	70	70	2
9	4	4	4
10	80	80	5
11	81	81	4
12	56	56	7
13	11	11	2
14	38	38	5
15	29	29	8
16	53	53	5
17	5	5	5
18	50	50	2
19	86	86	4
20	64	64	6
21	62	62	3
23	27	27	5
24	92	92	1
26	42	42	7
27	25	25	6
28	100	100	6
29	77	77	2
30	58	58	3
32	33	33	5
33	44	44	4
34	9	9	2
35	39	39	6
36	20	20	9
37	61	61	4
39	94	94	5
40	79	79	3
41	24	24	3
42	82	82	3
43	91	91	5
44	32	32	4
46	40	40	3
49	67	67	1
51	22	22	5
52	10	10	7
54	88	88	2
55	41	41	2
56	55	55	6
60	95	95	4
62	23	23	1
63	43	43	1
66	45	45	4
67	18	18	8
74	78	78	5
76	87	87	5
77	76	76	6
82	28	28	3
83	8	8	7
84	49	49	2
85	54	54	2
91	75	75	3
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, name, description) FROM stdin;
2	Clothing	Bonum, affirmatis nullam omnino fore. De.
3	Home & Garden	Si essent vera, nihil afferrent, quo iucundius, id est iudicabit nulla ad legendum his esse potiora. Quid est cur tam multi sint Epicurei, sunt aliae quoque causae, sed multitudinem haec maxime allicit, quod ita putant dici ab illo, recta et honesta quae sint, ea.
4	Sports	Quidam autem non tam solido quam splendido nomine, virtutem autem nixam hoc.
5	Books	Neque eum Torquatum, qui hoc primus cognomen invenerit, aut torquem illum hosti.
6	Toys	Inesse notionem, ut alterum esse appetendum, alterum aspernandum sentiamus. Alii autem, quibus ego assentior, dum modo de isdem rebus ne Graecos quidem legendos putent. Res vero bonas verbis electis graviter ornateque dictas quis non legat? Nisi qui se Latina scripta.
7	Health & Beauty	Voluptate, ut ab ea nullo modo poterimus sensuum iudicia defendere. Quicquid porro animo cernimus, id omne oritur a.
8	Automotive	Hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat. Hanc ego cum teneam sententiam, quid est cur tam multos legant, quam legendi sunt. Quid enim me prohiberet Epicureum esse, si probarem, quae.
9	Jewelry	Succumbere doloribus eosque humili animo inbecilloque ferre miserum est, ob eamque debilitatem animi multi parentes, multi amicos, non nulli patriam, plerique.
10	Stationery	Et solida corpora ferri deorsum suo pondere ad lineam, hunc naturalem esse omnium corporum motum. Deinde ibidem homo acutus, cum illud ocurreret, si omnia deorsus e regione ferrentur et, ut dixi, ad lineam, numquam fore ut.
1	Electronics	Aut ipse doctrinis fuisset instructior -- est enim, quod tibi ita videri necesse est, quid aut ad naturam aut contra sit, a natura ipsa iudicari. Ea quid percipit aut quid malum, sensu iudicari, sed animo etiam ac ratione intellegi. Some extra info.
\.


--
-- Data for Name: orderitems; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orderitems (order_item_id, order_id, product_id, quantity, price) FROM stdin;
1	54	54	53	2.29
2	7	7	7	54.99
3	77	77	76	3.49
4	62	62	2	34.99
6	80	80	2	99.99
8	39	39	47	10.99
9	23	23	38	89.99
10	51	51	22	49.99
11	34	34	51	1.89
12	13	13	95	24.99
13	62	62	87	22.99
14	39	39	96	39.99
15	92	92	34	8.99
16	19	19	12	4.49
17	63	63	61	12.99
18	75	75	39	10.99
19	92	92	91	2.49
20	21	21	19	1.99
21	50	50	43	29.99
22	39	39	62	7.49
23	30	30	74	2.99
24	87	87	37	29.99
25	14	14	91	34.99
26	76	76	67	15.99
27	43	43	29	29.99
28	76	76	21	99.99
29	23	23	49	44.99
30	60	60	8	3.39
31	74	74	39	39.99
32	65	65	30	5.99
33	6	6	86	89.99
35	33	33	75	34.99
36	36	36	34	4.99
37	41	41	76	5.29
38	69	69	42	34.99
39	40	40	73	3.79
40	4	4	75	1.99
41	18	18	23	3.99
42	14	14	59	5.99
43	60	60	62	29.99
44	88	88	73	39.99
45	12	12	65	9.99
46	82	82	41	3.29
47	46	46	6	29.99
48	34	34	47	24.99
49	26	26	47	3.29
50	35	35	33	29.99
51	36	36	36	29.99
52	44	44	41	79.99
53	79	79	68	4.49
54	97	97	39	249.99
55	69	69	4	19.99
56	38	38	17	3.49
57	72	72	68	19.99
58	36	36	18	4.49
59	18	18	14	7.49
60	63	63	59	14.99
61	12	12	4	4.49
62	4	4	87	79.99
63	34	34	57	29.99
64	22	22	12	34.99
65	40	40	81	24.99
66	99	99	26	12.99
67	23	23	46	24.99
68	46	46	34	89.99
69	89	89	26	15.99
70	66	66	12	3.29
71	73	73	34	44.99
72	95	95	35	7.99
73	60	60	44	49.99
74	72	72	78	22.99
75	58	58	96	5.49
76	12	12	68	3.79
77	25	25	96	34.99
78	12	12	38	249.99
79	54	54	75	3.49
80	10	10	71	14.99
82	29	29	18	34.99
83	83	83	62	49.99
84	71	71	12	24.99
85	16	16	3	29.99
86	80	80	34	59.99
87	96	96	22	2.99
88	68	68	89	1.99
89	40	40	40	1.99
90	100	100	47	3.29
91	8	8	98	4.09
92	14	14	23	2.99
93	43	43	46	4.99
94	65	65	48	4.19
95	15	15	41	3.29
96	43	43	49	4.19
97	42	42	88	34.99
98	59	59	83	39.99
99	91	91	66	39.99
100	87	87	72	5.49
101	105	4	1	29.99
102	105	5	1	39.99
104	107	16	3	2.49
106	109	4	4	29.99
107	110	6	3	2.49
108	110	4	2	29.99
109	111	4	2	29.99
110	111	5	3	39.99
111	112	102	1	1.00
112	112	4	1	29.99
113	113	102	1	1.00
114	113	5	2	39.99
115	114	102	1	1.00
116	114	5	2	39.99
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.orders (order_id, user_id, order_date, status, total_amount) FROM stdin;
1	64	2024-07-09 11:45:22	Cancelled	52.83
2	85	2024-09-24 05:13:35	Delivered	58.07
3	55	2024-06-07 08:00:27	Returned	50.63
4	78	2024-08-31 02:56:29	Refunded	56.43
5	97	2024-11-08 16:20:59	Pending	61.18
6	12	2024-01-01 04:29:58	Processing	39.83
7	21	2024-02-02 01:44:37	Shipped	42.01
8	32	2024-03-15 20:46:02	Returned	44.93
9	79	2024-09-03 02:31:22	Returned	56.63
10	79	2024-09-03 05:54:02	Returned	56.64
11	81	2024-09-09 21:47:50	Shipped	57.09
12	33	2024-03-17 21:14:24	Cancelled	45.07
13	69	2024-07-28 13:24:50	Shipped	54.13
14	33	2024-03-30 20:20:23	Shipped	45.96
15	79	2024-03-19 13:20:18	Returned	45.19
16	32	2024-08-05 21:45:04	Cancelled	56.61
17	90	2024-07-26 01:38:35	Shipped	54.70
18	49	2024-04-07 00:07:23	Shipped	53.96
19	19	2024-03-14 23:45:10	Refunded	46.45
20	12	2024-10-12 03:44:26	Delivered	44.87
21	19	2024-05-16 14:20:18	Pending	59.30
22	22	2023-11-28 00:27:10	Processing	49.15
23	79	2024-01-28 08:50:55	Pending	37.50
24	38	2024-01-01 04:58:24	Processing	41.69
25	65	2024-01-27 14:17:00	Processing	39.83
26	97	2024-02-06 00:25:53	Returned	41.64
27	24	2024-09-02 21:45:56	Shipped	42.28
28	91	2024-04-05 01:10:32	Cancelled	56.62
29	69	2024-07-12 20:53:09	Delivered	46.31
30	82	2024-05-03 07:40:44	Refunded	53.06
31	40	2024-11-07 14:46:11	Processing	48.24
32	48	2024-02-14 01:42:03	Refunded	61.10
33	22	2024-10-15 03:47:19	Cancelled	42.83
34	8	2024-07-27 20:28:27	Returned	59.50
35	83	2024-09-14 23:59:03	Shipped	54.09
36	86	2024-04-13 13:24:30	Delivered	57.44
37	55	2024-05-12 00:37:42	Processing	46.89
38	94	2024-02-07 12:54:04	Pending	48.84
39	20	2023-12-17 19:26:47	Returned	42.38
40	81	2024-09-18 16:25:15	Delivered	38.85
41	62	2024-09-28 09:19:36	Shipped	57.69
42	64	2024-06-06 20:52:33	Refunded	58.36
43	34	2024-03-13 02:35:34	Processing	50.60
44	15	2024-01-29 17:02:19	Returned	44.74
45	47	2024-09-09 02:11:41	Cancelled	60.41
46	13	2024-06-12 13:40:54	Cancelled	41.78
47	46	2024-07-03 06:43:57	Shipped	57.04
48	35	2024-07-11 00:15:16	Delivered	50.99
49	10	2024-01-11 02:46:25	Pending	52.41
50	23	2024-05-07 13:24:55	Refunded	52.93
51	10	2024-01-04 23:33:28	Cancelled	45.43
52	81	2024-10-03 17:55:28	Delivered	40.51
53	18	2024-07-22 20:03:01	Cancelled	48.53
54	83	2024-05-05 05:36:43	Shipped	40.09
55	53	2024-07-14 20:19:45	Pending	58.72
56	25	2024-03-25 22:46:56	Processing	53.74
57	35	2023-12-23 16:13:17	Pending	48.37
58	28	2023-12-26 03:15:56	Returned	53.20
59	3	2024-09-10 01:05:12	Processing	45.62
60	32	2024-01-24 09:09:18	Delivered	39.25
61	29	2024-05-17 23:30:21	Pending	42.60
62	2	2024-01-02 22:54:42	Returned	39.42
63	55	2024-09-16 10:16:03	Delivered	57.10
64	27	2024-05-30 10:03:18	Processing	41.42
65	14	2024-02-19 02:32:42	Delivered	49.24
66	49	2024-06-05 03:31:10	Shipped	39.95
67	21	2024-03-25 04:16:38	Cancelled	57.54
68	61	2024-06-26 18:22:23	Refunded	50.09
69	41	2024-02-29 10:26:39	Pending	43.17
70	94	2024-11-12 16:09:13	Shipped	50.49
71	33	2023-11-29 04:51:29	Pending	45.57
72	9	2024-03-13 22:08:19	Delivered	51.96
73	39	2024-03-03 09:26:10	Processing	43.88
74	27	2023-11-26 10:24:38	Refunded	61.45
75	23	2024-06-07 15:44:40	Delivered	37.58
76	27	2024-02-26 12:58:07	Processing	44.80
77	84	2024-10-29 10:28:57	Cancelled	44.08
78	2	2024-01-07 10:00:41	Shipped	37.39
79	32	2024-05-17 02:45:33	Refunded	50.66
80	99	2024-02-02 03:07:21	Shipped	43.68
81	82	2024-04-15 11:47:10	Shipped	60.48
82	87	2024-10-28 20:09:02	Pending	40.26
83	32	2024-04-11 02:50:17	Delivered	49.19
84	96	2024-03-19 15:13:57	Pending	42.01
85	21	2023-12-20 05:27:30	Shipped	52.14
86	10	2024-06-01 10:23:09	Shipped	47.03
87	1	2023-12-27 02:20:57	Processing	60.44
88	31	2024-04-08 18:44:47	Cancelled	46.73
89	34	2024-02-24 19:34:17	Processing	45.19
90	87	2024-06-30 22:31:17	Processing	39.02
91	50	2024-02-09 12:35:00	Returned	50.23
92	60	2024-02-24 14:13:15	Pending	39.48
93	73	2024-09-20 11:49:41	Shipped	46.57
94	78	2023-11-26 09:26:52	Refunded	44.73
95	5	2024-03-13 07:15:35	Shipped	43.56
96	58	2024-10-04 00:58:12	Returned	52.25
97	48	2024-03-31 10:52:16	Returned	42.52
98	67	2024-11-15 17:05:36	Refunded	43.55
99	68	2024-09-14 10:35:35	Shipped	57.82
100	69	2024-09-11 15:14:46	Refunded	37.39
113	111	2024-12-02 14:49:21.289938	Paid	80.98
109	111	2024-12-01 04:35:13.514666	Paid	119.96
105	111	2024-11-28 03:41:58.468173	Paid	244.93
110	111	2024-12-01 05:09:01.594302	Paid	67.45
107	111	2024-11-28 04:38:03.286526	Paid	7.47
108	111	2024-11-28 04:40:57.490341	Paid	104.97
111	111	2024-12-01 05:16:25.525071	Paid	179.95
114	124	2024-12-03 15:06:56.942706	Paid	80.98
112	111	2024-12-01 08:27:49.385244	Paid	30.99
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (payment_id, order_id, amount, payment_date, payment_method) FROM stdin;
1	100	61.90	2024-11-19 05:07:09	Credit Card
2	6	38.37	2023-12-10 18:45:25	Google Pay
3	70	54.31	2024-07-31 05:07:36	PayPal
4	23	50.71	2024-06-08 09:25:33	Google Pay
5	52	42.69	2024-02-12 01:42:43	Credit Card
6	2	49.87	2024-05-27 04:12:08	Cryptocurrency
7	37	37.32	2023-11-25 08:58:07	Google Pay
8	96	46.14	2024-04-02 13:42:51	Bank Transfer
9	54	60.77	2024-11-02 18:40:20	Bank Transfer
10	35	50.26	2024-06-01 20:44:41	Apple Pay
11	41	45.49	2024-03-24 01:00:39	Venmo
12	67	51.72	2024-06-23 06:59:09	Credit Card
13	77	45.56	2024-03-25 00:43:05	PayPal
14	21	47.15	2024-04-17 06:03:44	Venmo
15	83	53.52	2024-07-19 15:09:28	Check
16	41	38.23	2023-12-08 17:31:20	Apple Pay
17	58	56.16	2024-08-27 05:33:04	Bank Transfer
18	99	42.18	2024-02-04 11:53:35	Cryptocurrency
19	36	52.45	2024-07-03 21:58:20	PayPal
20	94	57.54	2024-09-16 09:18:16	Debit Card
21	48	43.99	2024-03-02 02:30:03	Credit Card
22	60	47.16	2024-04-17 10:28:47	Cryptocurrency
23	58	51.44	2024-06-19 01:36:14	PayPal
24	11	61.50	2024-11-13 11:10:32	Bank Transfer
25	19	45.88	2024-10-27 05:56:32	Cryptocurrency
26	90	60.33	2024-05-12 23:06:02	Google Pay
27	6	48.90	2024-06-25 01:41:06	Google Pay
28	24	51.85	2024-02-15 23:24:44	Bank Transfer
29	32	42.96	2024-06-16 10:15:16	Debit Card
30	28	51.26	2023-12-29 23:52:33	PayPal
31	39	39.68	2024-01-26 21:21:24	Check
32	7	41.59	2024-10-13 01:32:28	Cryptocurrency
33	96	59.36	2023-12-09 10:30:32	Bank Transfer
34	29	38.28	2024-10-18 06:26:00	Venmo
35	55	59.71	2024-03-14 12:18:24	Google Pay
36	57	42.83	2024-02-28 12:39:08	Google Pay
37	59	44.84	2024-04-09 14:10:41	Apple Pay
38	32	43.82	2023-12-13 21:48:43	Bank Transfer
39	19	46.62	2024-11-04 13:05:00	Cash
40	14	38.58	2024-03-03 05:41:01	Venmo
41	26	60.90	2024-06-07 07:14:36	PayPal
42	39	44.07	2024-06-15 04:21:26	Credit Card
43	84	50.63	2024-05-28 09:21:05	PayPal
44	58	51.17	2024-06-22 03:29:00	Debit Card
45	88	49.96	2024-03-14 14:54:43	Cash
46	20	51.65	2024-01-26 04:41:34	PayPal
47	32	44.85	2024-01-08 11:33:55	Venmo
48	62	41.54	2024-08-28 04:54:06	Cryptocurrency
49	55	40.33	2024-02-21 17:11:34	Apple Pay
50	51	56.23	2024-04-09 02:20:56	Venmo
51	8	43.35	2024-01-28 16:20:42	Credit Card
52	27	46.59	2024-09-20 19:44:47	Google Pay
53	31	41.71	2024-08-31 22:58:29	Venmo
54	39	57.84	2024-06-18 03:57:35	PayPal
55	76	56.48	2024-10-06 13:49:19	Cryptocurrency
56	66	51.37	2024-11-05 23:27:18	Apple Pay
57	68	58.92	2024-01-30 21:07:57	Venmo
58	24	60.99	2024-03-14 08:01:08	Debit Card
59	3	41.86	2024-07-02 18:02:51	PayPal
60	38	44.83	2024-06-05 22:48:57	Check
61	77	52.37	2024-05-23 04:17:20	Cryptocurrency
62	25	50.54	2023-12-18 20:43:10	Credit Card
63	65	49.60	2024-02-25 07:07:39	PayPal
64	89	38.92	2024-05-03 03:03:22	Cryptocurrency
65	96	43.60	2024-03-11 08:19:50	Apple Pay
66	46	48.23	2024-04-08 22:51:42	Debit Card
67	61	44.62	2024-08-23 17:56:54	Debit Card
68	52	46.58	2024-07-17 20:31:27	Cash
69	68	55.92	2024-07-23 10:03:29	Credit Card
70	99	53.40	2024-02-13 18:58:39	Venmo
71	61	53.78	2023-11-29 19:30:08	Cash
72	50	42.81	2024-02-12 20:01:48	Debit Card
73	89	37.62	2024-01-03 01:25:24	Bank Transfer
74	47	42.75	2024-11-12 17:06:40	Check
75	29	39.96	2024-04-06 09:20:20	Credit Card
76	18	61.45	2024-08-25 15:37:11	Venmo
77	97	46.40	2024-02-16 13:37:14	Check
78	2	56.05	2024-07-14 13:07:37	Google Pay
79	68	43.00	2024-06-29 02:32:20	Bank Transfer
80	92	53.18	2023-11-30 23:47:31	Credit Card
81	60	59.01	2024-05-26 01:54:22	Venmo
82	41	60.89	2024-07-23 23:38:57	Check
83	16	48.29	2024-06-29 09:03:02	PayPal
84	60	52.12	2024-05-18 10:38:20	Venmo
85	15	37.70	2024-10-07 22:31:35	PayPal
86	63	49.80	2024-07-26 09:27:08	PayPal
87	89	53.82	2024-05-07 22:39:04	Apple Pay
88	75	61.52	2024-03-02 07:00:03	PayPal
89	15	52.14	2024-07-11 10:45:29	Venmo
90	34	43.45	2024-01-24 11:35:26	Cryptocurrency
91	83	49.28	2024-01-06 15:51:34	Venmo
92	3	60.49	2024-02-20 03:35:47	Apple Pay
93	88	59.01	2024-09-11 11:19:00	Cryptocurrency
94	83	53.99	2024-01-29 03:37:53	Credit Card
95	54	48.56	2024-10-14 14:38:12	Google Pay
96	2	44.01	2023-11-26 16:00:19	Bank Transfer
97	69	52.96	2024-07-22 23:55:29	Google Pay
98	66	41.42	2024-02-15 19:41:43	Check
99	83	40.21	2024-10-19 05:55:13	Check
100	26	43.25	2024-06-24 20:57:58	Credit Card
101	109	119.96	2024-12-01 04:51:10.78136	Credit Card
102	111	179.95	2024-12-01 05:17:34.140043	PayPal
103	112	30.99	2024-12-01 08:29:05.897606	Bank Transfer
104	113	80.98	2024-12-02 14:49:38.503689	PayPal
105	114	80.98	2024-12-03 15:07:12.39803	PayPal
\.


--
-- Data for Name: productimages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productimages (image_id, product_id, image_url, created_at) FROM stdin;
1	6	https://cdbaby.com/ignoratione/hoc.yml?quae&laudatur&industria&ne&fortitudo	2023-12-09 19:37:50
2	60	https://ox.ac.uk/nec/praeterea/de.cer?profecto&numquam	2024-06-26 01:13:17
3	20	http://springer.com/hominem/maximi/cadere/possunt/nulla/tradit.jks?ad&arbitrium&suum&scribere	2024-01-30 15:20:53
5	43	https://fastcompany.com/chrysippo/praetermissum/in/ei.jks	2024-04-23 08:08:46
6	57	https://vkontakte.ru/nisi/cum/ut.scf?idem&licet	2024-06-13 12:41:28
7	96	https://netvibes.com/carum/esse/iucundum/est/propterea/voluptate.bat?quis&est	2024-01-06 13:46:08
8	41	https://bbc.co.uk/fingi/potest/adipiscendarum.ods?vendibiliora	2024-11-03 03:21:34
9	90	https://independent.co.uk/in/primis/inter.html?ad	2024-04-17 17:23:00
10	72	https://photobucket.com/et/rutilius/multo/etiam/magis/non.xz?dici&possunt&ut&enim&medicorum	2024-10-13 01:06:21
11	73	https://youtube.com/inquam/et.mshxml?epicurus&terminari&summam&voluptatem	2024-08-06 19:30:36
12	5	https://surveymonkey.com/haec/minus.yml?voluptate&idem&etiam&dolorem	2024-03-16 05:28:09
13	72	https://quantcast.com/quia/voluptas/sit/aspernatur/aut/videre.wmv?et	2024-10-03 18:58:40
14	95	https://wufoo.com/plerisque/notissima/est/quam/a/illud.msh2	2024-08-11 00:34:39
15	46	https://slashdot.org/dolor/sit/amet/consectetur/adipisci/nos.scf?igitur&est&inquit&audire&enim	2023-12-07 17:05:48
16	35	https://japanpost.jp/qui/haec/subtilius/tenebo.mdb	2024-08-07 07:30:04
17	90	https://who.int/disciplinam/est.bash?propterea&quod&ipsa	2024-10-31 14:01:13
18	59	https://rakuten.co.jp/ad/cognitionem/omnium/et.yml?oritur	2024-10-14 09:46:43
19	44	https://princeton.edu/quos/torquate.md?sine&metu&vivere&quae	2024-03-20 05:55:20
20	10	http://altervista.org/modo/nec/possunt.msi?praeclara&sunt	2024-08-13 07:15:58
21	64	https://sphinn.com/concessum/in.mkv?in&hae&esse	2024-04-03 14:03:50
22	87	https://yolasite.com/nos/ea/quae/non.md?declinare&atomum&sine&causa	2024-05-05 07:39:56
23	21	https://ucoz.ru/ennii/medeam/aut/antiopam/tum.tsv?persecuti&sumus&ut&autem&a	2024-04-18 12:02:49
24	68	https://barnesandnoble.com/animum/excruciant/et/servire.mdf?lucifugi&maledici&monstruosi	2024-10-14 03:04:30
25	43	https://businessweek.com/quae/sed.html	2024-03-02 01:59:50
26	71	https://hhs.gov/omnium/philosophorum/sententia/tale/inquit.json?nulla	2024-11-12 23:18:26
27	21	https://nytimes.com/quod/tranquillat/animos/tum/si.json?iusteque&vivatur&nec&sapienter&honeste	2024-06-20 13:03:17
28	92	https://ezinearticles.com/conferebamus/neque/erat/caret.html	2024-04-28 07:14:56
29	54	https://fc2.com/summa/appareat/iis.bash?ita&paratus&est&ut	2023-12-25 20:20:51
30	71	https://studiopress.com/est/tamquam/artifex/conquirendae/et/graviterque.desktop?atque&haec	2024-07-09 04:46:56
31	66	http://gmpg.org/moderatius/tamen/id/nostris.yaml?rem&commenticiam	2024-10-02 09:05:07
32	73	https://hibu.com/amicos/primis.bz2	2024-02-02 07:59:56
33	57	https://sciencedirect.com/intellegunt/errore/fallare.bz2?geometriaque&perfecto	2024-07-23 21:29:47
34	14	https://so-net.ne.jp/faciendum/ii/voluptatem/maximam/adipiscuntur/opinor.conf?tibi	2024-04-23 07:26:20
35	95	https://gov.uk/videbitur/transferam/et/maxime/cum.docx?comprobavit&quod&quam&magnum	2024-02-04 17:01:10
36	84	https://google.fr/dolorem/sunt/prosperum.bin?quibus&tam&multis&tamque&variis	2024-10-20 02:54:08
37	27	http://craigslist.org/ut/etiamsi/nulla/semper.xml?carere&possent&sine&dolore&tum	2024-06-02 01:31:52
38	24	https://pagesperso-orange.fr/tum/illud/in/primis/distinctio.xlsx?et&ad&eos&cum	2024-08-04 17:01:50
39	58	https://discovery.com/quaeritur/esse.accdb?esse&solam&quae	2024-07-16 12:29:31
40	82	http://skyrock.com/quis/est/qui/ennii/scaevola.msh2xml	2024-08-10 12:26:54
41	91	http://theguardian.com/tibi/et/sequitur.toml?honestum&non&tam&id	2024-06-15 04:59:31
42	74	https://squarespace.com/nobis/philosophia/defensa/amaret.sig?dixi&hausta&e&fonte&naturae	2024-11-09 08:59:41
43	82	https://globo.com/quaeritur/sit/pulcherrimum/etenim/si/ad.jsp?vitae&degendae	2024-09-21 09:49:40
44	51	https://hexun.com/poena/legum/odioque/civium/ex.msh2?expetendis&quid&fugiat	2024-04-17 23:53:40
45	46	https://who.int/cohaerescant/ex/quo/vitam/amarissimam/hoc.asc?minuendas	2024-02-25 03:15:28
46	66	https://myspace.com/constituant/in/reque/eo/meliore/aspernatur.ps1xml	2024-02-14 05:01:24
47	93	https://spiegel.de/tribuat/quid/in/omni/re/cum.crt	2024-06-18 23:15:10
48	23	https://thetimes.co.uk/servare/id/diligi.psd1	2024-09-12 21:21:39
49	7	https://people.com.cn/depravatum/ipsa/natura/incorrupte/atque/legendus.pem?civitatis&p&scaevolam&mque&manilium	2024-10-17 23:16:11
50	89	https://phoca.cz/fructu/habendus/errem.mdb?inmortalibus	2024-08-14 00:41:04
51	43	https://dyndns.org/pueros/non/didicisse/profectus.odg?neque	2024-03-16 02:35:45
53	50	https://walmart.com/voluptatibus/ut/nulli/propter/eas/a.exe?facere&ipsa&per&se	2024-05-22 22:57:22
54	85	http://scientificamerican.com/beateque/aut.pfx?bonorum&voluptatem&ex	2024-05-03 11:39:21
55	78	https://surveymonkey.com/unum/quae/responsum.css?forensibus&operis&laboribus&periculis&non	2024-06-05 07:11:19
56	32	https://shop-pro.jp/augendas/cum/conscientia/incidunt.rar?quoque&causae&sed&multitudinem&haec	2024-01-13 19:48:25
57	67	http://google.co.jp/modum/tamen.pptx?hoc&commune&vitium&illae	2024-07-16 08:02:58
58	76	https://ca.gov/temporibus/nulla.csr?pugnantibus&et&contrariis&studiis	2024-10-22 14:22:03
59	50	https://acquirethisname.com/versuum/memoria/voluptatis/affert/nec/errata.tsv	2024-02-09 09:49:22
60	16	http://goo.ne.jp/suum/iudicium/sed.odt?percipiatur&quod&videamus&esse&finitum	2024-08-06 03:14:49
61	20	http://wisc.edu/pacuvii/spernat/aut/reiciat/quod/aequum.iso	2023-12-14 03:41:59
62	55	https://latimes.com/propter/amici/omnes.yml?in&animis&nostris	2024-10-10 08:13:28
63	22	https://ask.com/firmam/et/perpetuam/iucunditatem/causa.accdb?latinis&quod&inciderint&in&inculta	2024-04-23 02:42:04
64	7	https://tamu.edu/ea/putant/usque/neque.vcd?nec&cum&istis	2024-05-10 20:15:17
65	68	https://guardian.co.uk/bonorum/vel/bella.avi?voluptatem&aut&cum	2024-05-20 03:47:52
66	16	https://trellian.com/deinde/de.url?amicitia&quasi&claudicare&videatur	2024-09-24 17:35:18
67	95	https://bandcamp.com/plurimum/posuit/existimo.msh2?aliquo&laborat	2024-08-30 14:33:34
68	51	https://pinterest.com//probarent.p12?erit&enim&iam&de&omnium	2024-03-13 22:31:41
69	100	https://illinois.edu/nam/sententiae.gz?omnium&corporum	2024-05-03 01:34:52
71	73	https://vinaora.com/vicinum/non/vult/fodere/possumus.md?disputationi	2024-08-22 00:00:23
72	54	https://icq.com/et/dignitatis/molestiae.iso?natura&cupiditatum&generibusque&earum&explicatis	2024-04-18 01:05:52
73	99	https://narod.ru/corrupti/est.pdf?cum&miraretur&ille&quidem&utrumque	2024-09-15 03:10:31
74	10	https://cbslocal.com/expetendam/et/dolorem/et.ps1xml?ita	2024-05-18 16:02:58
75	83	https://youku.com/docui/cognitionis/hausta.gif?theseo	2024-01-14 17:35:33
76	57	https://cloudflare.com/referri/oporteat/ipsum/quandam.css?ac&partiendo&docet&non	2024-01-31 20:38:15
77	14	https://myspace.com/litteris/concederetur.mdf	2024-09-26 05:32:23
78	66	http://uiuc.edu/libidinem/fingitur//ait/enim/ut.mshxml	2024-02-07 10:16:45
79	27	https://nih.gov/principio/inquam/in/physicis/erat.xlsx?quam&graecam&quando	2023-12-12 18:04:21
80	100	https://xinhuanet.com/senectutem/chremes.pub?nec&libidinum&nec&epularum&nec	2024-07-23 00:26:31
81	46	http://cloudflare.com/qui/omnino/avocent/vos.avi?hoc	2024-10-30 07:47:51
82	32	https://spotify.com/diceret/cum/praesertim/illa/perdiscere/ullus.accdb?neque&tam&docti	2024-11-18 22:54:59
83	40	https://google.ca/sentit/quem/dominos.odt	2023-11-25 00:18:57
84	29	http://wsj.com/tum/id/quod/praesenti.jsp?ut&verterunt&nostri&poetae	2024-02-05 06:07:16
85	60	https://fda.gov/in/et.rpm?nihil	2024-08-10 19:14:16
86	21	http://addtoany.com/modo/efficiatur/concludaturque/malivoli.odt?poetis&aut&inertissimae&segnitiae&est	2024-06-03 20:45:55
87	86	https://sakura.ne.jp/genus/est/et/expedita/distinctio/voluptate.odt?quo&melius&viveremus&eas	2024-11-15 06:39:36
88	95	https://furl.net/extremum/etiam/indoctum/quas.wav	2023-12-26 11:47:53
89	27	https://webmd.com/vero/id/quidem/inquam/id.jsp?qui&blanditiis	2024-09-17 01:27:38
90	80	https://cnet.com/constituant/in/reque/eo/quam.bash?conclusionemque&rationis&et	2024-06-12 18:09:46
91	39	https://wisc.edu/expetendam/et/insipientiam/meam.desktop?aut&officiis&debitis&aut	2024-01-09 21:56:11
92	65	https://amazonaws.com/gravissimis/rebus/non/delectet/se.png?quod&maxime	2024-07-17 05:24:42
93	75	https://uol.com.br/quid/iudicat/quo/aut/petat/modo.bz2	2023-12-15 16:48:14
95	50	https://huffingtonpost.com/quis/eas/aut/laudabilis/voluptate.gpg?esse&firmissimum&sunt&autem	2023-12-12 06:13:00
96	83	http://newyorker.com/democritum/laudatum/etiam.xlsx?cognitioque&rerum	2024-03-15 23:57:52
97	15	https://berkeley.edu/voluptas/quid.xz?evertunt&totam&etiam	2024-04-12 09:36:11
99	33	https://addtoany.com/quae/in/rebus/aut/expetendis/metu.json?est&alienus&democritea&dicit	2024-06-26 01:34:44
100	9	https://psu.edu/consule/ipsi/se/indicaverunt/voluptatem.cfg?videtur&multis&voluptatibus&cum	2024-05-14 02:56:27
101	102	https://www.sathya.in/media/90596/catalog/silver1%20(2).jpg	2024-12-01 07:55:43.828623
102	103	https://cdn-icons-png.flaticon.com/512/4804/4804045.png	2024-12-01 07:58:21.586136
94	4	https://sohu.com/dicam/aut/oratoribus/esse.gz?cohaerescent&sive&aliae&declinabunt	2024-12-02 14:47:15.728228
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (product_id, name, description, price, stock, category_id, created_at, seller_id) FROM stdin;
5	Karaoke Microphone	Wireless microphone for singing and performances.	39.99	2159	1	2024-02-07 18:16:53	120
4	Multicolored LED Strip Lights	Flexible LED lights for creative home lighting designs.	29.99	4664	3	2024-05-09 10:53:02	120
6	Hot Dog Buns	Soft buns perfect for stuffing with your favorite hot dogs.	2.49	6868	6	2024-07-29 02:22:22	34
10	Siphon Coffee Maker	Unique coffee brewing method for a flavorful experience.	49.99	3406	6	2024-03-24 10:00:56	120
102	Xiaomi Redmi 12	Too Good Smartphone For This World	1.00	1	1	2024-12-01 06:04:58.840048	120
7	Non-Stick Grill Mat	Reusable mat that prevents food from sticking to the grill.	19.99	3791	4	2024-04-07 11:54:46	49
8	Infrared Thermometer	Non-contact thermometer for checking temperatures instantly.	39.99	309	6	2023-12-02 01:14:30	43
9	Asian Noodle Salad Kit	A pre-packaged salad kit with noodles and Asian-style dressing.	4.99	5585	10	2024-06-12 03:26:48	7
11	Fried Rice	Pre-cooked vegetable fried rice, just heat and serve.	4.29	5195	2	2024-05-28 21:22:29	31
12	Zesty Garlic Marinade	A tangy marinade for meats and veggies, packed with garlic flavor.	4.49	9129	6	2024-10-19 20:28:23	93
13	Beef Jerky	Savory, protein-rich beef jerky for on-the-go snacking.	5.99	5275	9	2024-01-17 21:35:16	85
14	Ceramic Planter Set	Set of decorative ceramic planters for indoor plants.	39.99	1589	10	2024-05-31 01:39:56	87
15	Apple Juice	Refreshing apple juice, 100% juice with no added sugar.	3.29	5255	2	2024-09-28 23:20:05	58
16	Tandoori Chicken Marinade	Delicious and tangy marinade for grilling or baking chicken.	2.49	8558	1	2024-03-01 22:21:38	50
17	Adjustable Kneeling Pad	Comfortable kneeling pad for gardening or home projects.	18.99	2792	5	2024-01-29 15:03:39	10
18	Juice Extractor	Efficient juicer for fresh fruit and vegetable juices.	99.99	1909	1	2024-11-09 00:56:34	45
19	Cable Knit Cardigan	Cozy cable knit cardigan to layer during chilly evenings.	49.99	9680	3	2024-10-25 00:10:30	89
20	Teriyaki Chicken Bowl	Ready-to-eat chicken bowl with teriyaki sauce and rice.	6.49	9270	1	2024-01-12 12:53:51	48
21	Personal Blender	Compact blender for quick smoothies and shakes.	39.99	1443	6	2023-12-07 03:46:02	15
22	Hand Mixer	Compact hand mixer for easy baking.	29.99	449	3	2024-11-18 08:17:36	94
23	Basic V-Neck T-Shirt	A staple v-neck t-shirt that pairs well with anything.	19.99	9935	2	2024-11-18 03:15:22	16
24	Elegant Lace Dress	A stunning lace dress perfect for special occasions.	79.99	9929	3	2024-04-18 10:15:54	84
25	Non-Stick Crepe Pan	Perfectly designed pan for making crepes and pancakes.	29.99	4090	6	2024-06-25 00:52:25	3
26	Insulated Lunch Box	Durable lunch box designed to keep food fresh and cool.	24.99	5937	3	2024-04-05 13:15:26	63
27	Smart WiFi Plug	Control appliances remotely using your smartphone.	19.99	3738	4	2023-12-05 04:49:22	69
28	Veggie Burger Patties	Delicious veggie burger patties for grilling or frying.	5.99	395	8	2024-07-30 00:52:56	54
29	Organic Apples	Crisp and delicious organic apples.	1.89	6893	9	2024-02-06 23:24:54	85
30	High-Speed Blender	Powerful blender for smoothies and soups.	99.99	4759	8	2023-12-07 14:58:29	85
31	Electric Bike	Eco-friendly electric bike with a 30-mile range.	899.99	2138	7	2024-07-21 18:00:55	36
32	Sliced Avocado	Ready-to-eat avocado slices, perfect for tacos.	2.79	461	1	2024-05-28 03:35:41	21
33	Peas (frozen)	Frozen green peas, a great addition to meals.	1.89	6667	7	2024-02-09 02:45:08	31
34	Samsung Galaxy Smartwatch	Stylish smartwatch with fitness tracking and notifications.	249.99	5175	3	2024-01-04 11:42:54	33
35	Acoustic Guitar	Beginner-friendly acoustic guitar with natural finish.	199.99	2196	2	2024-02-07 14:58:26	81
36	Karaoke Microphone	Wireless microphone for singing and performances.	39.99	1223	8	2024-02-08 21:23:31	27
37	Paprika	Rich and sweet paprika spice for seasoning.	1.79	2155	4	2024-03-11 05:29:12	35
38	Salt and Pepper Grinder Set	Adjustable grinders for fresh spices at the table.	19.99	5524	2	2024-08-12 15:55:04	92
39	Pest Control Traps	Non-toxic traps for catching household pests safely.	22.99	2190	9	2024-11-07 00:01:11	31
40	Chocolate Chip Cookie Dough	Ready-to-bake cookie dough packed with chocolate chips.	5.49	3046	5	2024-09-09 04:44:55	24
41	Faux Leather Leggings	Stylish faux leather leggings for a trendy outfit.	49.99	7266	9	2024-06-21 09:16:05	43
42	Nut Butter Cups	Delicious dark chocolate with creamy nut butter inside.	3.99	9625	3	2024-10-12 17:14:01	44
43	Himalayan Pink Salt	Natural mineral salt with a subtle flavor, ideal for cooking and seasoning.	1.99	8018	9	2024-07-13 16:56:57	51
44	Chickpea Salad Deluxe	Chickpeas mixed with fresh vegetables and herbs, a nutritious snack or salad.	4.29	5837	8	2024-02-26 20:19:52	78
45	Peach Preserves	Sweet and fruity peach preserves, perfect for spreading on toast.	3.79	8934	3	2024-01-29 16:07:42	32
46	Mango Chunks	Frozen mango chunks for smoothies or snacking.	4.89	7237	7	2023-11-26 06:41:12	52
49	Juice Extractor	Efficient juicer for fresh fruit and vegetable juices.	99.99	4818	9	2024-02-12 00:00:55	75
50	Air Purifier	HEPA air purifier for clean indoor air.	129.99	1911	6	2024-01-14 14:20:30	75
51	Pumpkin Spice Latte Mix	Instant mix for delicious pumpkin spice lattes at home.	3.29	151	8	2024-08-04 07:56:49	41
52	Cauliflower Crust Pizza	A gluten-free pizza crust made from cauliflower.	7.99	5951	8	2024-03-15 07:47:13	5
53	Handheld Garment Steamer	Quick and easy way to remove wrinkles from clothes.	34.99	6402	1	2024-09-01 05:05:37	29
54	Kids' Educational Tablet	Learning tablet with kid-friendly educational apps.	129.99	2275	10	2024-10-03 04:52:31	37
55	Gluten-Free Biscuits	Fluffy biscuits made without gluten	3.79	1499	7	2024-01-09 13:19:43	34
56	Coffee Subscription Service	Monthly subscription for freshly roasted coffee delivered to your door.	29.99	7038	3	2024-04-26 19:24:44	70
57	Lemon Herb Chicken	Marinated chicken grilled with lemon and herbs.	7.49	3158	8	2024-09-29 10:33:03	74
58	Pesto Pasta Salad	Cold pasta salad tossed with pesto and fresh vegetables.	4.99	7800	5	2024-02-08 02:22:29	65
59	Pasta Maker Machine	Manual pasta maker for creating fresh pasta at home.	59.99	8674	6	2024-09-22 10:15:49	57
60	Sweet Potato Chips	Deliciously crunchy sweet potato chips, seasoned to perfection.	2.99	1361	3	2024-01-24 21:22:55	75
61	Noise-Canceling Headphones	High-quality headphones that block out external noise for immersive listening.	119.99	8233	9	2024-01-28 14:30:37	75
62	Blueberry Chia Jam	Homemade jam made with blueberries and chia seeds, no added sugar.	4.99	4319	9	2024-02-19 23:18:37	77
63	Electric Egg Cooker	Automatically cooks eggs to your desired level.	29.99	8571	5	2024-07-04 13:48:05	44
64	Caramel Apple Taffy	Sweet and chewy taffy flavored like caramel apples, great for fall.	1.99	2168	10	2024-06-04 15:56:42	82
65	Peanut Butter Chocolate Chip Bars	Chewy bars made with peanut butter and chocolate chips.	4.59	8379	5	2024-08-01 15:31:36	50
66	Toy Building Set	Creative building set for kids to spark imagination.	29.99	1780	4	2024-02-08 20:43:11	90
67	Scent Diffuser Oil	Essential oil blends for a soothing atmosphere in your home.	14.99	7383	2	2024-10-02 14:13:46	79
68	Coconut Oil	Versatile organic coconut oil for cooking and baking.	6.49	1882	3	2024-05-19 15:44:53	74
69	Sliced Cheese	Assorted sliced cheese, perfect for sandwiches.	4.49	2493	8	2024-09-13 14:47:50	91
70	Salt and Pepper Grinder Set	Adjustable grinders for fresh spices at the table.	19.99	6198	8	2024-05-26 12:06:38	37
71	Garlic Herb Cream Cheese	Spreadable cream cheese blended with garlic and herbs.	2.99	5380	8	2024-08-12 04:21:54	92
72	Coconut Milk	Rich coconut milk for curries and desserts.	2.49	6965	5	2024-11-10 02:18:44	79
73	Coconut Oil Spray	A zero-calorie coconut oil spray for cooking and baking.	4.99	2189	8	2024-08-08 11:49:56	93
74	Ice Cream	Rich and creamy ice cream, available in various flavors.	5.99	8657	1	2024-04-09 03:25:04	67
75	Granola Clusters	Crunchy granola clusters, perfect for snacking or topping yogurt.	4.99	4943	8	2023-11-25 06:43:59	27
76	Linen Trousers	Breathable linen trousers perfect for hot weather.	44.99	8139	1	2024-10-25 20:31:10	58
77	Vegetable Spring Rolls	Crispy spring rolls filled with vegetables	6.49	5130	1	2024-05-15 02:03:53	56
78	Over-the-Door Hooks	Convenient hooks that utilize door space for hanging items.	12.99	7252	5	2024-07-04 14:03:00	14
79	Wall Art	Abstract canvas print to enhance home decor.	45.00	9709	9	2024-02-20 05:29:10	81
80	Honey Ginger Tea	Soothing tea with honey and ginger, great for relaxation.	2.99	7152	5	2024-08-21 05:22:22	66
81	Salsa	Fresh and zesty salsa, perfect for nachos.	3.49	3836	7	2024-07-30 15:28:33	62
82	Coconut Oil	Versatile organic coconut oil for cooking and baking.	6.49	124	4	2024-05-05 14:29:55	9
83	Kids' Science Experiment Kit	Engaging kit with science experiments for children.	29.99	9293	5	2024-06-11 06:04:58	70
84	Nutty Trail Mix	A blend of nuts, seeds, and dried fruits for snacking.	4.29	4818	8	2024-02-20 07:45:59	92
85	Sesame Noodles	Chilled noodles dressed in sesame sauce, ready to eat.	5.99	6198	8	2024-10-01 07:44:53	50
86	Portable Ice Maker	Compact ice maker for creating ice at home or in offices.	199.99	2500	8	2024-09-29 19:35:57	27
87	Almond Flour Tortillas	Gluten-free tortillas made from almond flour, perfect for various wraps and meals.	4.99	7500	1	2024-04-18 15:13:24	96
88	Plant-Based Protein Bars	Nutritious protein bars for on-the-go snacking.	19.99	6910	8	2024-10-22 20:43:41	53
89	Cinnamon Sugar Popcorn	Sweet popcorn coated in a mixture of cinnamon and sugar.	2.89	4559	3	2024-11-16 09:51:04	74
90	Pumpkin Pie Spice	A blend of spices that brings the taste of fall to your baked goods.	2.99	5560	2	2024-03-20 13:11:31	30
91	Water-Resistant Bluetooth Speaker	Durable speaker designed for outdoor use with water resistance.	59.99	2502	10	2024-01-18 06:57:56	95
92	Strawberry Fruit Spread	Natural fruit spread bursting with real strawberry flavor.	3.59	8622	10	2024-02-07 22:48:22	78
93	Noise-Canceling Headphones	High-quality headphones that block out external noise for immersive listening.	119.99	8581	10	2024-07-24 20:46:07	10
94	Warm Knit Beanie	Stay warm with this stylish knit beanie in various colors.	19.99	4095	10	2024-08-15 22:39:45	93
95	Tabletop Fire Pit	Compact and stylish indoor/outdoor fire pit for ambiance.	79.99	9211	7	2024-08-07 02:26:38	88
96	Stainless Steel Grater	Multi-functional grater for cheese and vegetables.	14.99	4318	8	2024-08-10 19:20:57	47
97	Pocket Blanket	Compact, waterproof blanket for picnics and events.	24.99	9882	2	2024-04-25 22:18:23	22
98	Sourdough Bread	Artisan-made sourdough bread with a tangy flavor.	4.99	3301	5	2024-08-18 02:25:38	77
99	Thai Coconut Curry Sauce	A rich coconut curry sauce perfect for simmering vegetables or meats.	3.99	1600	2	2023-12-03 00:56:08	1
100	Basil-infused Olive Oil	Extra virgin olive oil infused with fresh basil.	6.99	2164	2	2024-08-11 04:47:44	120
103	Some Clothing	Some Nice Clothing	123.00	123	2	2024-12-01 07:56:43.280032	120
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, product_id, user_id, rating, comment, created_at) FROM stdin;
1	91	91	4	Scribendi ordinem adiungimus, quid habent, cur Graeca anteponant iis, quae et terroribus cupiditatibusque detractis et omnium falsarum opinionum temeritate derepta certissimam se nobis ducem praebeat ad voluptatem. Sapientia enim est a Cyrenaicisque melius liberiusque defenditur, tamen eius modi esse iudico, ut nihil homine videatur indignius. Ad maiora enim quaedam nos natura genuit et conformavit, ut mihi.	2024-10-16 17:26:07
2	83	83	4	Quae quidque efficiat, de materia disseruerunt, vim et causam efficiendi reliquerunt. Sed hoc commune vitium, illae Epicuri propriae ruinae: censet.	2024-09-17 09:10:07
3	31	31	2	Clamat Epicurus, is quem vos nimis voluptatibus esse deditum dicitis; non posse iucunde vivi, nisi sapienter, honeste iusteque vivatur, nec sapienter, honeste, iuste, nisi.	2024-03-12 04:01:01
4	71	71	2	Sentiant non esse faciendum, ii voluptatem maximam adipiscuntur praetermittenda voluptate. Idem etiam dolorem saepe perpetiuntur, ne, si id non faciant, incidant in maiorem. Ex quo vitam amarissimam necesse.	2024-02-27 08:52:54
5	84	84	3	Intereant cotidie. Quae etsi mihi nullo modo poterimus sensuum iudicia defendere. Quicquid porro animo cernimus, id omne oritur a sensibus; qui si omnes atomi declinabunt, nullae umquam cohaerescent, sive aliae declinabunt, aliae suo nutu recte ferentur, primum erit hoc quasi, provincias atomis.	2024-08-04 16:56:42
6	50	50	4	Non recusandae. Itaque earum rerum defuturum, quas natura non depravata desiderat. Et quem ad modum temeritas et libido et ignavia semper animum excruciant et semper sollicitant turbulentaeque sunt, sic inprobitas si cuius in mente consedit, hoc ipso, quod adest, turbulenta est; si vero molita.	2024-09-21 17:20:54
7	34	34	2	Diceret? Cum praesertim illa perdiscere ludus esset. Quam ob rem tandem, inquit, non satisfacit? Te enim iudicem aequum.	2024-05-20 12:58:16
8	68	68	2	Autem detracta voluptate aegritudinem statim consequi, nisi in voluptatis locum dolor forte successerit, at contra gaudere nosmet omittendis doloribus, etiamsi voluptas ea, quae praeterierunt.	2024-03-22 09:49:29
10	62	62	2	Dare, quae recte, quae oblique ferantur, deinde eadem illa atomorum, in quo.	2024-05-08 06:37:10
11	37	37	3	Ea quid percipit aut quid malum, sensu iudicari, sed animo etiam ac ratione intellegi posse et voluptatem pleniorem.	2024-06-04 20:48:47
12	29	29	3	Venire vetuit, numquid tibi videtur de voluptatibus suis cogitavisse? Sed ut omittam pericula, labores, dolorem.	2024-07-01 11:25:37
13	98	98	2	Voluptatibus, videtisne quam nihil molestiae consequatur, vel illum, qui dolorem ipsum, quia dolor sit, amet, consectetur, adipisci velit.	2024-04-29 12:00:06
14	32	32	2	Quae de philosophia litteris mandamus, legere assueverit, iudicabit nulla ad legendum his esse potiora. Quid est cur verear, ne ad eam non possim accommodare.	2024-04-02 18:34:08
16	54	54	4	Summis ingeniis exquisitaque doctrina philosophi Graeco sermone tractavissent, ea Latinis litteris mandaremus, fore ut hic noster labor in varias reprehensiones incurreret. Nam quibusdam, et iis servire, qui vel utrisque litteris uti velint vel, si suas habent.	2024-11-10 19:46:28
17	37	37	2	In tranquillitate vivi potest omnium cupiditatum ardore restincto. Cupiditates enim sunt insatiabiles, quae non modo non inopem, ut vulgo putarent.	2024-03-15 23:32:09
18	10	10	1	Ratio docet, tum denique poterit aliquid cognosci et percipi. Quos qui tollunt et nihil.	2023-11-24 09:13:52
19	82	82	3	Aut in liberos atque in sanguinem suum tam crudelis fuisse, nihil ut de commodis suis cogitarent? At id ne ferae quidem.	2024-04-01 11:55:43
20	55	55	2	Arare aut aliquid ferre denique' -- non enim illum ab industria, sed ab inliberali labore deterret --, sic isti curiosi, quos offendit noster minime nobis iniucundus labor. Iis.	2023-12-25 16:32:19
22	67	67	1	Morte finiri, parvos multa habere intervalla requietis, mediocrium nos esse dominos, ut, si.	2024-09-15 00:24:36
23	43	43	3	Aeque atque nostra et pariter dolemus angoribus. Quocirca eodem modo sapiens erit affectus erga amicum.	2024-06-05 12:15:20
24	27	27	4	Retinent, ne voluptate victi faciant id, quod sentiant non esse faciendum, ii voluptatem maximam adipiscuntur praetermittenda voluptate. Idem etiam dolorem saepe perpetiuntur, ne, si amicitiam propter nostram voluptatem expetendam putemus, tota amicitia quasi claudicare videatur. Itaque primos congressus copulationesque et consuetudinum instituendarum voluntates fieri propter voluptatem; quod vero securi percussit filium, privavisse se etiam videtur multis.	2024-05-10 19:40:23
25	89	89	3	Audire voluerint, liberabuntur: istae enim vestrae eximiae pulchraeque virtutes nisi voluptatem efficerent, quis eas aut.	2024-07-21 19:49:08
26	71	71	2	Arare aut aliquid ferre denique' -- non enim illum ab industria, sed ab inliberali labore deterret.	2024-04-24 01:18:30
27	10	10	3	Nudus est. Tollit definitiones, nihil de dividendo ac partiendo docet, non quo ignorare vos arbitrer.	2024-02-24 01:52:29
28	14	14	2	Epicuri sententia de voluptate, nihil scilicet novi, ea tamen, quae te ipsum.	2024-10-08 22:16:34
29	97	97	2	Maximi cadere possunt, nulla spe proposita fore levius aliquando, nulla.	2024-02-05 02:18:15
30	35	35	4	Enim vestrae eximiae pulchraeque virtutes nisi voluptatem efficerent, quis eas aut laudabilis aut expetendas arbitraretur? Ut enim ad sapientiam perveniri potest, non paranda nobis solum ea, sed fruenda etiam sapientia est; sive hoc difficile est, tamen.	2024-08-03 18:15:24
31	21	21	1	Indignae philosophia mihi videri solent. Tum Torquatus: Prorsus, inquit, assentior; neque enim disputari sine.	2023-12-26 02:54:30
32	73	73	3	Cotidieque inter nos ea, quae corrigere vult, mihi quidem nulli satis eruditi videntur, quibus nostra ignota sunt. An 'Utinam ne in nemore . . .' nihilo minus.	2024-01-09 20:24:06
33	37	37	1	Nullam existimavit esse nec ad melius vivendum.	2024-04-14 15:04:39
34	17	17	1	Enim nobis, vel dicam aut oratoribus.	2024-11-06 22:01:23
35	55	55	2	--. Nam cum solitudo et vita sine amicis insidiarum et metus et aegritudines ad dolorem referuntur, nec praeterea.	2024-02-03 14:18:38
36	81	81	4	Homines optimi non intellegunt totam rationem everti, si ita melius sit, migrare de vita. His rebus peccant, cum e quibus haec efficiantur ignorant. Animi autem voluptates et dolores nasci fatemur e corporis voluptatibus et doloribus .	2024-06-08 21:55:17
38	11	11	1	Alii autem etiam amatoriis levitatibus dediti, alii petulantes, alii.	2024-04-02 15:04:27
39	52	52	3	Quid bonum sit aut quid iudicat, quo aut petat aut fugiat aliquid, praeter voluptatem et dolorem. Ad haec et quae fugiamus refert omnia. Quod.	2024-01-20 05:07:55
40	38	38	3	Voluptatem, nihil asperum nisi dolorem, de quibus ante dictum est, sic amicitiam negant posse a voluptate aut in.	2024-06-06 22:39:37
41	4	4	2	Et ab antiquis, ad arbitrium suum scribere? Quodsi Graeci leguntur.	2024-09-11 05:23:25
42	82	82	1	Utrumque, Phaedrum autem etiam amatoriis levitatibus dediti, alii petulantes, alii.	2023-11-20 20:37:11
43	28	28	3	Animumque et corpus, quantum efficere possimus, molestia liberemus. Ut enim virtutes, de quibus neque depravate.	2023-12-29 02:08:03
44	25	25	4	Etsi sit elegans, personae tamen et dignitatis esse negent. Contra quos omnis dicendum breviter existimo. Quamquam philosophiae quidem vituperatoribus satis responsum est eo libro, quo a populo Romano locatus sum, debeo profecto, quantumcumque possum, in eo ipso parum vidit, deinde hoc quoque alienum; nam.	2024-05-27 05:31:07
45	28	28	1	Ad quiete vivendum, caritatem, praesertim cum omnino nulla sit.	2024-04-06 02:54:27
46	28	28	1	Aut aliquid ferre denique' -- non.	2023-12-03 14:28:42
47	35	35	3	Posse, quam ex hoc facillime perspici potest: Constituamus aliquem magnis, multis, perpetuis fruentem et animo.	2024-09-14 08:22:51
48	95	95	2	Sollicitudines, quibus eorum animi noctesque diesque exeduntur, a diis inmortalibus sine ullo metu vera.	2024-03-01 01:02:04
49	51	51	1	Ipso id quidem licebit iis.	2024-02-16 17:06:37
50	22	22	4	Cupiditatum generibusque earum explicatis, et, ut dixi, ad lineam, hunc naturalem esse omnium corporum motum. Deinde ibidem homo acutus, cum illud ocurreret, si omnia.	2024-09-04 05:48:01
51	17	17	2	Accusantibus, quod pecunias praetorem in provincia cepisse arguerent, causam apud se dicere iuberet reque ex utraque parte audita.	2024-02-27 14:55:15
52	22	22	1	Epicurus? Qui unum genus posuit earum cupiditatum, quae essent et naturales et necessariae.	2024-03-24 21:07:03
53	33	33	4	Erimus, cum didicerimus quid natura desideret. Tum vero, si stabilem scientiam rerum tenebimus, servata illa, quae quasi saxum Tantalo semper impendet, tum superstitio, qua qui affecti sunt in culpa qui officia deserunt.	2024-10-30 15:05:16
54	88	88	2	Quae pertinerent ad bene beateque vivendo a Platone disputata sunt, haec explicari non placebit Latine? Quid? Si nos non interpretum fungimur munere, sed tuemur ea, quae dices, libenter.	2024-05-22 01:03:52
55	61	61	2	Naturales quidem multa desiderant, propterea quod ipsa natura incorrupte atque integre iudicante. Itaque negat opus esse ratione neque disputatione, quam ob rem tandem, inquit.	2024-02-07 15:28:06
56	53	53	2	Si aliquod aeternum et infinitum impendere malum nobis opinemur. Quod idem licet.	2024-01-20 04:53:39
57	11	11	4	Amicitias comparare, quibus partis confirmatur animus et excelsus omni est liber cura et angore, cum et mortem contemnit, qua qui utuntur, benivolentiam sibi conciliant et, quod aptissimum est ad cognitionem omnium, regula, ad quam omnia iudicia rerum dirigentur, numquam ullius oratione victi sententia desistemus. Nisi autem rerum natura cognita levamur superstitione, liberamur mortis metu, non conturbamur.	2024-02-06 11:24:33
58	5	5	3	Qui autem, si maxime hoc placeat, moderatius tamen id confidet fore semper occultum. Plerumque improborum facta primo suspicio insequitur, dein sermo atque fama, tum accusator, tum iudex; Multi etiam, ut.	2024-03-18 06:44:58
59	92	92	1	Laborat, nemo igitur est non miser. Accedit etiam mors, quae.	2024-10-06 01:42:21
61	87	87	1	Clariora sunt, si omnia dixi hausta e fonte naturae, si tota oratio.	2024-05-30 16:46:17
62	34	34	2	--, quod ipsum nullam ad aliam rem, ad id omnia referri oporteat, ipsum autem nusquam. Hoc Epicurus in voluptate ponatur, sed sine hoc institutionem omnino amicitiae.	2023-12-28 18:05:08
63	85	85	4	Inter nos ea, quae audiebamus, conferebamus, neque erat umquam controversia, quid ego intellegerem, sed quid probarem. Quid igitur est? Inquit; audire enim cupio, quid non probes eius, a quo dissentias. Quid enim me prohiberet Epicureum esse, si probarem, quae ille.	2023-12-06 14:10:35
64	45	45	3	Illo est, tum innumerabiles mundi, qui et oriantur et intereant cotidie. Quae etsi mihi nullo modo poterimus sensuum iudicia defendere. Quicquid porro animo cernimus.	2024-10-18 22:07:48
65	13	13	3	Fugienda est, summum bonum consequamur? Clamat Epicurus, is quem vos nimis voluptatibus esse deditum dicitis; non posse reperiri. Quapropter si ea.	2024-05-11 07:45:10
66	54	54	1	Et Triarius te hortatore facimus, consumeret.	2024-10-02 02:38:28
67	38	38	1	Quidem depravare videatur. Ille atomos quas appellat, id.	2024-03-23 08:35:45
68	4	4	4	Doleamus animo, cum corpore dolemus, fieri tamen permagna accessio potest, si aliquod aeternum et infinitum impendere malum nobis opinemur. Quod idem licet transferre in voluptatem, ut ea maior sit, mediocritatem desiderent. Sive enim ad sapientiam perveniri.	2024-09-25 08:56:12
69	81	81	2	Ut plura nemini e nostris, qui haec subtilius velint tradere et negent satis esse, quid bonum sit aut quid malum, sensu iudicari, sed animo etiam ac ratione intellegi.	2024-05-01 22:51:21
70	30	30	4	Doloris putat Epicurus terminari summam voluptatem, ut ea maior sit, si nihil tale metuamus. Iam illud quidem physici, credere aliquid esse minimum, quod profecto numquam putavisset, si a Polyaeno, familiari suo, geometrica.	2024-04-03 23:04:47
71	16	16	2	Tum fit ut aegritudo sequatur, si illa mala sint, laetitia, si bona.	2024-02-12 13:01:53
72	17	17	4	Quidem, inquit, totum Epicurum paene e philosophorum choro sustulisti. Quid ei reliquisti, nisi te, quoquo modo loqueretur, intellegere, quid diceret? Aliena dixit in physicis nec ea ipsa, quae ab illo inventore veritatis et quasi architecto beatae vitae disciplinam iuvaret. An.	2024-06-02 00:35:07
73	46	46	2	Sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus.	2024-04-06 07:12:46
74	62	62	2	Operam malle consumere. Postremo aliquos futuros suspicor, qui me ad alias litteras.	2023-12-03 19:16:13
75	96	96	1	Voluptate, ut ab ea nullo modo nec divelli nec distrahi.	2024-03-08 13:59:00
76	49	49	1	Temperantiam postulant in eo, quod semel admissum.	2024-01-25 01:06:45
77	64	64	3	Secumque discordans gustare partem ullam liquidae voluptatis et liberae potest. Atqui pugnantibus et contrariis studiis consiliisque semper utens nihil quieti videre, nihil tranquilli potest. Quodsi corporis gravioribus morbis vitae iucunditas impeditur, quanto magis animi morbis impediri.	2024-01-17 01:43:40
78	25	25	2	Ut e patre audiebam facete et urbane Stoicos irridente, statua est in.	2024-01-18 08:05:01
79	97	97	1	Animi noctesque diesque exeduntur, a.	2024-05-03 17:22:04
80	50	50	4	Tamen satis acuti, qui verentur ne, si id non faciant, incidant in maiorem. Ex quo efficeretur mundus omnesque partes mundi, quaeque in eo quoque elaborare, ut sint opera, studio, labore meo doctiores cives mei, nec cum istis tantopere pugnare, qui Graeca legere malint, modo legant illa ipsa, ne simulent, et iis servire.	2024-07-02 06:04:22
81	15	15	2	Multa desiderant, propterea quod ipsa natura, ut ait ille, sciscat et probet, id est vel summum bonorum vel.	2024-11-05 01:53:49
82	36	36	1	Aliquem magnis, multis, perpetuis fruentem et.	2024-05-16 06:47:53
83	40	40	1	Et erant illa Torquatis.' Numquam hoc ita.	2024-08-24 02:07:10
84	34	34	1	Illud dixeris: 'Haec enim ipsa mihi sunt voluptati, et erant illa.	2024-02-18 05:38:36
85	13	13	2	In qua maxime ceterorum philosophorum exultat oratio, reperire exitum potest, nisi derigatur ad voluptatem, voluptas autem est sola, quae nos a libidinum impetu et.	2024-11-06 06:37:26
86	96	96	3	Non probes, eum quem ego arbitror unum vidisse verum maximisque erroribus animos hominum liberavisse et omnia tradidisse, quae pertinerent ad bene beateque vivendo a Platone disputata sunt, haec explicari non placebit Latine? Quid? Si nos non interpretum fungimur munere.	2024-05-19 20:38:15
87	85	85	4	Propter voluptates expetendam et insipientiam propter molestias esse fugiendam? Eademque ratione ne temperantiam quidem propter se ipsos penitus perdiderunt, sic robustus animus et a spe pariendarum voluptatum seiungi non potest. Atque ut odia, invidiae, despicationes adversantur.	2024-01-13 09:23:42
88	99	99	2	Pedalis fortasse; tantum enim esse omnino in nostris poetis aut.	2024-04-14 18:50:23
90	73	73	4	Magna afficitur voluptate. Dolores autem si qui incurrunt, numquam vim tantam habent, ut non plus voluptatum habeat quam dolorum. Nam et laetamur amicorum laetitia aeque atque nostra et pariter dolemus angoribus. Quocirca eodem modo sapiens erit affectus erga amicum, quo in se ipsum, quosque labores propter suam voluptatem susciperet, eosdem suscipiet propter.	2024-04-11 16:03:56
91	98	98	1	Curis hominum non intellegentium nihil dolendum esse.	2024-03-22 19:53:52
92	7	7	4	Diogenem, Antipatrum, Mnesarchum, Panaetium, multos alios in primisque familiarem nostrum Posidonium. Quid? Theophrastus mediocriterne delectat, cum tractat locos ab Aristotele ante tractatos? Quid? Epicurei num desistunt de isdem, de quibus ante dictum est, sic amicitiam negant posse a voluptate discedere. Nam cum solitudo et vita sine amicis insidiarum.	2024-11-05 04:43:28
93	65	65	2	Prosperum nisi voluptatem, nihil asperum nisi dolorem, de quibus ante dictum est, sic amicitiam negant posse a voluptate.	2024-09-24 17:34:27
94	79	79	1	Quidem rerum facilis est et ad tranquillitatem ferant, quid.	2024-01-06 12:43:19
95	43	43	2	Placuit Epicuro medium esse quiddam inter dolorem et voluptatem; illud enim ipsum, quod quibusdam.	2024-11-13 16:33:49
96	15	15	2	Statue contra aliquem confectum tantis animi corporisque doloribus, quanti in hominem maximi cadere possunt, nulla spe proposita fore levius aliquando, nulla praeterea neque praesenti nec expectata voluptate, quid.	2023-11-25 22:45:45
97	67	67	2	Me tamen laudandis maioribus meis corrupisti nec segniorem ad respondendum reddidisti. Quorum facta quem ad modum.	2024-08-12 04:19:57
98	73	73	2	Inopem, ut vulgo putarent, sed locupletiorem etiam esse quam vacare omni dolore et molestia perfruique maximis et animi.	2024-11-09 22:13:04
99	22	22	1	Omnino fore. De qua omne certamen est? Tuo vero id quidem, inquam, arbitratu.	2023-12-14 14:10:34
100	21	21	4	Graecis isdem de rebus alia ratione compositis, quid est, cur nostri a nostris non legantur? Quamquam, si plane sic verterem Platonem aut Aristotelem, ut verterunt nostri poetae fabulas, male, credo, mererer de meis civibus, si ad eorum cognitionem divina illa ingenia transferrem. Sed id neque feci adhuc nec mihi tamen, ne faciam.	2024-07-13 16:01:32
101	4	111	5	Гуд!	2024-12-01 05:49:22.816825
102	10	111	1	bruh	2024-12-01 05:54:53.316488
103	102	111	5	Nice smartphone	2024-12-01 06:08:16.360154
104	5	111	4	dhjagdhjwe	2024-12-02 14:48:10.955292
105	102	124	5	rewhgwaerhireaw	2024-12-03 15:06:32.901713
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (role_id, role_name) FROM stdin;
1	Admin
2	Moderator
3	Guest
4	Seller
5	Customer
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (session_id, user_id, created_at, expires_at) FROM stdin;
1	7	2023-12-15 09:21:02	2023-12-16 09:21:02
2	94	2024-10-28 18:32:39	2024-10-29 18:32:39
3	42	2023-12-05 00:29:49	2023-12-06 00:29:49
4	33	2024-08-24 14:36:21	2024-08-25 14:36:21
5	91	2024-04-20 14:22:17	2024-04-21 14:22:17
6	45	2024-03-17 19:45:57	2024-03-18 19:45:57
7	22	2024-10-17 04:58:22	2024-10-18 04:58:22
8	41	2024-05-02 09:38:39	2024-05-03 09:38:39
9	53	2024-02-06 03:38:16	2024-02-07 03:38:16
10	77	2024-05-29 02:53:22	2024-05-30 02:53:22
11	96	2023-12-15 22:38:04	2023-12-16 22:38:04
12	6	2024-08-13 13:09:49	2024-08-14 13:09:49
13	56	2024-08-02 12:17:58	2024-08-03 12:17:58
14	71	2024-08-26 18:32:45	2024-08-27 18:32:45
15	28	2024-11-02 17:21:46	2024-11-03 17:21:46
16	52	2023-12-09 00:44:56	2023-12-10 00:44:56
17	49	2024-06-10 03:10:30	2024-06-11 03:10:30
18	78	2024-08-03 14:51:18	2024-08-04 14:51:18
19	90	2024-02-28 23:03:06	2024-02-29 23:03:06
20	38	2024-05-15 22:18:34	2024-05-16 22:18:34
21	8	2024-08-30 06:41:04	2024-08-31 06:41:04
22	54	2024-10-12 19:48:32	2024-10-13 19:48:32
23	35	2024-04-06 12:32:11	2024-04-07 12:32:11
24	33	2023-12-17 13:24:09	2023-12-18 13:24:09
25	42	2024-06-02 12:26:06	2024-06-03 12:26:06
26	4	2024-03-24 16:21:02	2024-03-25 16:21:02
27	46	2024-09-08 11:24:28	2024-09-09 11:24:28
28	32	2024-03-19 12:09:55	2024-03-20 12:09:55
29	83	2024-08-06 12:58:50	2024-08-07 12:58:50
30	70	2024-04-21 06:22:05	2024-04-22 06:22:05
31	74	2024-05-04 20:49:13	2024-05-05 20:49:13
32	90	2024-06-01 04:16:05	2024-06-02 04:16:05
33	89	2024-07-11 12:49:03	2024-07-12 12:49:03
34	94	2024-03-16 00:26:03	2024-03-17 00:26:03
35	8	2024-10-21 17:05:03	2024-10-22 17:05:03
36	68	2024-09-16 22:42:29	2024-09-17 22:42:29
37	7	2024-07-30 17:24:30	2024-07-31 17:24:30
38	80	2024-08-15 22:55:23	2024-08-16 22:55:23
39	39	2024-10-14 04:57:57	2024-10-15 04:57:57
40	33	2024-10-09 19:16:46	2024-10-10 19:16:46
41	33	2024-05-21 01:44:43	2024-05-22 01:44:43
42	71	2024-07-22 16:15:24	2024-07-23 16:15:24
43	4	2024-10-28 07:30:08	2024-10-29 07:30:08
44	55	2023-12-16 20:22:06	2023-12-17 20:22:06
45	44	2024-07-23 00:25:38	2024-07-24 00:25:38
46	89	2023-12-14 19:35:21	2023-12-15 19:35:21
47	23	2024-09-06 01:57:40	2024-09-07 01:57:40
48	46	2024-04-08 05:11:37	2024-04-09 05:11:37
49	95	2024-03-18 09:55:26	2024-03-19 09:55:26
50	43	2024-03-18 19:56:34	2024-03-19 19:56:34
51	95	2024-08-04 15:36:14	2024-08-05 15:36:14
52	24	2023-12-03 21:59:55	2023-12-04 21:59:55
53	59	2024-06-05 16:10:28	2024-06-06 16:10:28
54	24	2024-04-26 20:59:46	2024-04-27 20:59:46
55	50	2024-10-09 08:09:39	2024-10-10 08:09:39
56	27	2024-02-10 18:11:08	2024-02-11 18:11:08
57	84	2024-05-03 17:35:36	2024-05-04 17:35:36
58	57	2024-10-31 04:49:28	2024-11-01 04:49:28
59	45	2024-04-22 15:30:07	2024-04-23 15:30:07
60	11	2024-10-30 15:32:08	2024-10-31 15:32:08
61	2	2024-02-14 01:55:48	2024-02-15 01:55:48
62	1	2024-06-20 17:25:28	2024-06-21 17:25:28
63	84	2023-12-23 13:58:47	2023-12-24 13:58:47
64	88	2024-02-13 18:00:55	2024-02-14 18:00:55
65	100	2024-05-19 06:14:26	2024-05-20 06:14:26
66	97	2024-02-24 06:05:05	2024-02-25 06:05:05
67	78	2024-09-22 03:28:54	2024-09-23 03:28:54
68	78	2024-06-14 08:09:37	2024-06-15 08:09:37
69	89	2024-05-02 13:49:28	2024-05-03 13:49:28
70	68	2024-10-26 01:43:57	2024-10-27 01:43:57
71	64	2023-11-25 01:39:17	2023-11-26 01:39:17
72	87	2023-11-21 07:03:47	2023-11-22 07:03:47
73	81	2024-09-21 16:08:57	2024-09-22 16:08:57
74	91	2024-03-13 03:56:17	2024-03-14 03:56:17
75	8	2024-10-06 16:10:31	2024-10-07 16:10:31
76	89	2024-11-17 16:47:56	2024-11-18 16:47:56
77	73	2024-11-06 13:11:57	2024-11-07 13:11:57
78	63	2024-08-29 13:28:04	2024-08-30 13:28:04
79	72	2024-07-22 13:28:48	2024-07-23 13:28:48
80	67	2024-06-12 10:54:17	2024-06-13 10:54:17
81	34	2024-08-30 01:49:12	2024-08-31 01:49:12
82	51	2024-10-10 07:19:56	2024-10-11 07:19:56
83	66	2024-07-25 01:08:24	2024-07-26 01:08:24
84	31	2024-07-09 17:32:29	2024-07-10 17:32:29
85	72	2024-04-25 18:58:45	2024-04-26 18:58:45
86	77	2024-11-09 16:59:44	2024-11-10 16:59:44
87	86	2024-09-08 14:39:41	2024-09-09 14:39:41
88	85	2024-10-16 16:44:37	2024-10-17 16:44:37
89	71	2023-12-18 20:13:50	2023-12-19 20:13:50
90	59	2024-10-09 18:00:42	2024-10-10 18:00:42
91	100	2024-07-05 09:59:29	2024-07-06 09:59:29
92	68	2024-08-08 05:44:05	2024-08-09 05:44:05
93	65	2024-07-20 14:58:59	2024-07-21 14:58:59
94	5	2024-03-22 21:29:23	2024-03-23 21:29:23
95	45	2024-05-23 00:41:18	2024-05-24 00:41:18
96	22	2024-01-21 16:45:17	2024-01-22 16:45:17
97	83	2024-08-16 19:20:17	2024-08-17 19:20:17
98	84	2024-07-17 23:11:10	2024-07-18 23:11:10
99	61	2024-03-10 02:52:28	2024-03-11 02:52:28
100	68	2024-08-09 05:59:11	2024-08-10 05:59:11
\.


--
-- Data for Name: shoppingcart; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shoppingcart (cart_id, user_id, created_at) FROM stdin;
1	1	2024-04-03 11:39:33
2	2	2024-10-17 18:47:31
3	3	2024-06-28 07:18:28
4	4	2024-04-14 04:43:16
5	5	2024-07-22 09:13:10
6	6	2024-08-03 18:43:17
7	7	2024-10-19 03:39:59
8	8	2024-08-10 13:28:58
9	9	2024-11-08 01:55:12
10	10	2024-01-14 22:25:34
11	11	2024-09-04 16:45:41
12	12	2024-03-22 09:34:01
13	13	2023-11-28 03:00:28
14	14	2024-10-06 12:26:20
15	15	2024-01-26 08:29:20
16	16	2024-01-29 04:33:59
17	17	2024-09-18 19:45:03
18	18	2024-10-16 02:07:37
19	19	2024-01-09 10:09:42
20	20	2024-09-11 12:50:53
21	21	2024-01-07 07:31:16
22	22	2024-05-30 22:59:28
23	23	2023-12-19 16:19:19
24	24	2024-11-10 18:52:27
25	25	2024-01-25 06:49:08
27	27	2024-01-20 22:14:55
28	28	2024-07-21 01:07:18
29	29	2024-05-02 01:12:59
30	30	2024-11-09 23:19:29
31	31	2023-12-27 18:15:27
32	32	2024-07-01 07:28:24
33	33	2023-11-23 23:38:07
34	34	2024-01-08 10:42:34
35	35	2024-11-10 05:28:15
36	36	2024-06-27 09:36:25
37	37	2024-08-29 22:23:35
38	38	2024-11-19 16:34:23
39	39	2024-06-08 10:50:13
40	40	2024-04-30 01:30:10
41	41	2024-01-27 15:34:10
42	42	2024-01-19 14:17:43
43	43	2024-04-25 04:09:44
44	44	2024-04-30 03:54:34
45	45	2024-10-19 23:10:29
46	46	2024-02-25 03:26:39
47	47	2023-12-13 15:55:16
48	48	2024-05-31 02:34:08
49	49	2024-01-20 10:25:40
50	50	2024-06-09 18:02:25
51	51	2024-07-18 11:55:00
52	52	2024-08-05 12:47:24
53	53	2024-08-14 16:50:18
54	54	2024-08-05 14:05:45
55	55	2023-12-23 22:55:45
56	56	2023-11-26 17:48:23
57	57	2024-09-22 08:11:08
58	58	2024-08-23 20:53:00
59	59	2024-02-09 02:22:55
60	60	2024-01-11 14:29:02
61	61	2024-09-25 23:55:51
62	62	2024-04-23 14:17:02
63	63	2024-07-12 19:02:45
64	64	2024-10-17 16:43:35
65	65	2024-08-30 10:34:53
66	66	2024-10-29 01:52:11
67	67	2024-07-20 09:19:49
68	68	2024-10-28 01:07:09
69	69	2024-02-12 05:07:11
70	70	2024-03-13 20:31:11
71	71	2024-09-25 10:26:16
72	72	2024-10-23 21:51:36
73	73	2024-01-19 18:03:05
74	74	2024-11-07 14:58:47
75	75	2024-09-05 01:47:57
76	76	2024-02-15 10:37:17
77	77	2024-09-04 05:40:26
78	78	2024-02-23 23:16:43
79	79	2024-09-13 02:57:58
80	80	2024-11-18 08:57:56
81	81	2024-01-01 22:56:25
82	82	2023-12-28 22:03:07
83	83	2024-05-20 19:58:43
84	84	2024-05-21 15:14:34
85	85	2024-06-20 08:53:21
86	86	2024-09-22 06:09:30
87	87	2024-11-17 12:06:55
88	88	2024-03-11 12:16:58
89	89	2023-11-27 20:59:10
90	90	2024-01-08 04:50:14
91	91	2024-01-21 15:39:25
92	92	2024-07-09 14:04:07
93	93	2024-03-13 02:34:34
94	94	2024-05-03 11:25:52
95	95	2024-01-03 02:19:28
96	96	2024-06-12 21:10:55
97	97	2024-01-08 11:51:33
98	98	2024-04-24 04:38:39
99	99	2024-06-17 09:37:06
100	100	2024-10-15 20:14:07
101	111	2024-11-28 02:03:19.89645
102	124	2024-12-03 15:06:39.700269
\.


--
-- Data for Name: useraddresses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.useraddresses (address_id, user_id, street, city, state, zip_code) FROM stdin;
1	93	13835 Utopia Place	Salt Lake City	Utah	84189
2	61	9087 Renee Terrace	Albuquerque	New Mexico	87190
3	68	10108 Thorncrest Drive	Staten Island	New York	10310
4	52	7735 Andrew Machol Court	Minneapolis	Minnesota	55487
5	45	8227 Irish Court	Biloxi	Mississippi	39534
6	60	6633 Lockhart Avenue	Baton Rouge	Louisiana	70826
7	25	8869 Edgefield Drive	Manchester	New Hampshire	03105
8	77	3704 Sharon Drive	Fort Lauderdale	Florida	33330
9	2	11490 Ludlow Place	Pittsburgh	Pennsylvania	15286
10	4	158 Bainan Place	Birmingham	Alabama	35279
11	34	523 Tampico Place	Peoria	Arizona	85383
12	90	4973 Nackman Place	Augusta	Georgia	30905
13	62	13352 Reid Road	Killeen	Texas	76544
14	25	9167 Arthur Place	Las Vegas	Nevada	89105
15	39	3680 Orange Court	Fort Lauderdale	Florida	33315
16	4	5744 Ragsdale Loop	Peoria	Illinois	61635
17	39	456 Kettle Loop	North Little Rock	Arkansas	72199
18	13	5774 Edgeworth Terrace	Rockford	Illinois	61105
19	25	1916 Barksdale Drive	San Diego	California	92145
20	88	3617 Privett Drive	Clearwater	Florida	34620
21	46	13159 Ventura Drive	New Orleans	Louisiana	70154
22	5	6775 Blake Lane	Tempe	Arizona	85284
23	73	696 Winthrop Terrace	Oklahoma City	Oklahoma	73190
24	63	10858 D'Angelo Lane	Boca Raton	Florida	33499
25	24	9412 Morrison Place	Baton Rouge	Louisiana	70820
26	45	3529 Williams Road	Asheville	North Carolina	28805
27	56	6620 Forest Grove Run	Austin	Texas	78732
28	82	8354 Somerset Avenue	Fresno	California	93786
29	97	12243 Eby Place	Seattle	Washington	98133
30	7	6443 Shorewood Street	Corona	California	92883
31	32	1028 Winterthur Loop	Alpharetta	Georgia	30022
32	78	14486 McKnight Loop	Topeka	Kansas	66629
33	97	933 Alcott Avenue	Anderson	South Carolina	29625
34	81	4757 Jim Street	Washington	District of Columbia	20022
35	19	6293 Arteaga Way	Santa Barbara	California	93106
36	50	11594 Jones Lane	Panama City	Florida	32405
37	4	3000 Ludlow Place	Seattle	Washington	98104
38	67	2236 Blanton Court	Nashville	Tennessee	37205
39	12	4336 Mossy Oak Drive	Santa Fe	New Mexico	87592
40	57	14440 Rayma Place	Danbury	Connecticut	06816
41	72	12012 Burtoft Lane	Detroit	Michigan	48258
42	99	9128 Brice Place	Roanoke	Virginia	24020
43	48	2787 Edenton Terrace	Dallas	Texas	75210
44	13	7379 Brody Court	Phoenix	Arizona	85025
45	7	14249 Ranchwood Terrace	New York City	New York	10175
46	35	12430 Mclin Lane	Sacramento	California	94273
47	66	562 Belle Grove Drive	Colorado Springs	Colorado	80930
48	29	9932 Eastwood Terrace	Durham	North Carolina	27705
49	62	1711 Brooks Avenue	Toledo	Ohio	43615
50	72	2528 Manisha Lane	Madison	Wisconsin	53726
51	65	8500 Woodbreeze Place	Worcester	Massachusetts	01605
52	71	10659 Davey Lane	San Bernardino	California	92405
53	87	14742 East Gaffney Avenue	San Francisco	California	94177
54	5	7082 Beauclair Place	Corona	California	92878
55	45	1830 Magrath Way	Savannah	Georgia	31422
56	95	2094 Enrique Drive	Tucson	Arizona	85715
57	77	925 Chimborazo Way	New York City	New York	10045
58	18	5169 Estes Run	Rochester	New York	14639
59	98	719 Tatman Terrace	Houston	Texas	77218
60	49	9804 Homeland Park Street	Orlando	Florida	32830
61	5	10047 Brine Way	Sioux City	Iowa	51110
62	7	13189 Daniel Hearns Way	Las Vegas	Nevada	89155
63	100	4267 Cecilia Court	Edmond	Oklahoma	73034
64	3	5396 Gallinule Court	Jamaica	New York	11447
65	90	9247 Duarte Lane	Hamilton	Ohio	45020
66	84	10726 Rieger Road	Fort Worth	Texas	76178
67	69	9686 Jarvis Court	Fort Worth	Texas	76105
68	36	10610 Nance Run	Phoenix	Arizona	85053
69	12	12953 Canyon Avenue	Metairie	Louisiana	70005
70	18	12888 Belknap Avenue	Pittsburgh	Pennsylvania	15274
71	56	604 Bay Meadows Circle	Denver	Colorado	80279
72	76	6695 Valentine Avenue	Spokane	Washington	99260
73	84	14167 Brittany Terrace	Tempe	Arizona	85284
74	51	11474 Hendricks Lane	Fresno	California	93721
75	19	2664 Tucson Trail	Huntington	West Virginia	25705
76	85	14591 Palo Alto Avenue	Tuscaloosa	Alabama	35487
77	20	7260 Sadie Avenue	Lubbock	Texas	79415
78	93	691 Berrington Loop	Dallas	Texas	75241
79	21	973 Parrish Place	Canton	Ohio	44710
80	35	14920 Lucas Court	Sacramento	California	95818
81	43	369 Columbia Place	Saint Petersburg	Florida	33710
82	63	13396 Cherokee Court	Denver	Colorado	80209
83	57	12479 Vestridge Avenue	Jackson	Mississippi	39216
84	25	10242 Eola Place	Philadelphia	Pennsylvania	19109
85	75	5299 Mi Tierra Way	Mobile	Alabama	36628
86	43	1757 Bianca Court	Valley Forge	Pennsylvania	19495
87	67	4476 Wisteria Street	Muskegon	Michigan	49444
88	30	2587 Bancroft Place	Fort Collins	Colorado	80525
89	94	8273 Lussier Court	El Paso	Texas	79923
90	8	11260 Flagstone Terrace	Hartford	Connecticut	06183
91	82	270 Oyster Place	Washington	District of Columbia	20062
92	60	11529 Cardona Way	Honolulu	Hawaii	96805
93	11	12478 Charlee Lane	Wichita	Kansas	67236
94	6	7540 Lake Miona Drive	Fresno	California	93786
95	56	2702 Lowe Court	Tulsa	Oklahoma	74184
96	22	12665 Picnic Place	Reno	Nevada	89595
97	70	2854 Gaskin Lane	Charlotte	North Carolina	28242
98	3	4346 Niblick Court	Fort Lauderdale	Florida	33320
99	16	13879 Tupper Court	Erie	Pennsylvania	16510
100	64	3050 Ambrosia Place	Topeka	Kansas	66667
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, username, password_hash, email, created_at, role) FROM stdin;
3	kde mitris30542	C2AafAA5fdE6aCFdadCE6e01fDc8fa17e1be40Ac6d4B51eB9Eb1fa9fAFeeAb21	kale.demitris@hotmail.com	2024-02-14 11:28:01	2
4	jkearle13486	f3cdDeBa999bAccBCeFA7E2bDfF1FEb97ECb80cA94CaF0E10BDCcfDaAEBdFd3B	joline.kearle@gmail.com	2024-08-11 07:24:56	4
5	bivannikov30030	5ed355eED1adF2DeebEb95B0DB4d1E9fB9C4bFdBbEdC70dEfefAfC09BE8CaA4b	babb.ivannikov@wanadoo.fr	2024-05-19 04:01:12	3
6	acreed56973	acBCbaFF3C6d4cbcaE83f2DcAefffe4BDd5bF8DCAb74d034AF5B00faefACBaDC	amitie.creed@yahoo.com	2024-05-09 07:07:27	3
7	jridd13665	b9dbDBAcfcdfCc90ECACFafa3EfACAEE42ABCAbf307fBDBCc3dE9DA1a6C94Ca7	jesse.ridd@hotmail.fr	2024-02-11 07:19:44	2
10	acritchley53958	fDDB5EEebFd6FbAA422E2f6BDAFdcaF0f11b22fCb0EB9Af4BECa9dEce05dcbBf	alli.critchley@aol.com	2024-05-06 10:32:01	2
11	nspikings10636	bcBC6D5523CeAAc7F4Cb7B04C9f9EcEA3DdDeCBdeE7dcbFFD6A4Daaa5Feb6Db5	norry.spikings@yahoo.com.br	2024-03-02 11:42:46	5
12	ckingsbury30328	2DeA5Fe0Bd92bfc5fEeD1D41dE8fC0EbC4bB9b20c00BFEaFe0ADaFDa5dFe0069	charissa.kingsbury@gmail.com	2024-10-03 21:48:52	2
13	ngerber24868	b2F0FD3Fe4a48d4Ccdb5A96C9eBF4baE64Dca6fA44d234b4e821F8dABbe3B5ba	nichol.gerber@hotmail.com	2024-08-16 00:09:10	5
14	rpavlenkov32184	9CE65DeECAcDAFBE9FAF7cbc11EEDbDDCb8bAdA9CF5dc8daC56cc9F9af33F09e	ryun.pavlenkov@hotmail.com	2024-02-05 01:00:20	3
15	gcharman19292	1Ad11EADA09AeE56FeCae9042ef5705ca2cBBbBee5Ffc65bF1C646DcfE7FCbBE	garik.charman@outlook.com	2024-06-06 20:39:40	4
16	ckidds30805	F1EDE6DB09F7FEd2abACAF10Eb33cC548c9FFBDDcEB13dB6ADdED6F9DFcfcfed	corbett.kidds@yahoo.com	2024-10-01 06:16:22	5
17	agommery22046	F9f179C2d21f47e04BccDDbcf8C8EACccaCBE25eaf4bea2aCAf34DDd12B8De46	amabel.gommery@tin.it	2024-05-24 13:22:09	5
18	bmcmanaman46133	c3Fbfd47ACcCF6BAE6b0624dcc86B2a6CDE86EFc74fbEba02AcE8F8aDDDEFaDa	bertie.mcmanaman@yahoo.com	2024-03-31 13:42:42	1
19	skaret40525	85Ed6E8CFe9AfAAdf0D4c4C8baA13faCDDdFf3E8bBAcc3AdD3bB290acDaEdf7A	sol.karet@yahoo.com	2024-08-05 21:06:37	3
20	estrick48242	aA90CB5ecEA4eDfaAc1F7dEbdCEdDcfcbDbB5C97EC3EcfbDfe35ebaBC0Fac7Af	emmalee.strick@gmail.com	2024-09-17 01:38:22	3
21	aelliss18624	CeeAecAaD85a6A3ABAbecEa0e0DeEd9fd3Ceca856AaAb5e1F52086Bd08Efba7E	aurore.elliss@gmail.com	2024-09-13 05:25:26	4
22	nwoodwing56103	9bD816E6Ee3b7d7deEAfAc9DF0FBB81A5d001d1d6Edf5C62FCCcb1a9EaCCeeb3	nap.woodwing@hotmail.com	2024-01-19 02:59:26	3
23	yfrake48570	d22BFceB6cA5Eaa7BDD206aDCDDbab1cCDDE4e47dBE80b4AadFA3b246c8DaBc0	yehudi.frake@hotmail.com	2023-12-23 18:21:17	5
24	rhillan52451	e8eEBf3cdbd9CfDAbFaAEE14CE0b6A44265048757AB52fBE6a3DEd8dECcb0aBA	raphael.hillan@gmail.com	2024-05-08 02:27:04	2
25	zpartington37175	6d0da77E49b4Ed7AcFCcbBb524F1b3f605CFA4B3F9cA0c9Dffc4eac3BCF5FAB8	zebadiah.partington@yahoo.com	2024-05-23 00:27:05	3
27	lmcgauhy37883	caddfBD101ceEcFBAe3BcA211Fdd3EC0AAca05C7a0E533FCED8c1FDD05c858dA	langsdon.mcgauhy@outlook.com	2024-07-06 18:32:51	3
28	echopy13245	DC6C1f3ced5fF6F1eDaaB6f87ab8F7Ec0b076Ff80d6ECFb109CaBdF32b4Ed40e	elizabet.chopy@hotmail.com	2024-05-18 11:15:23	4
29	kbeeken7036	f9BfF2ACcdcE2cbf4CB3df4a80B74fBbAC5ECfEBcd8DbA7C2d2CFBF3BfedaEFC	karia.beeken@aol.com	2024-10-08 13:22:40	2
30	bsomerscales52372	aFa8a4Ded0C1b9Da9ff5adB8AD44cB09F1ddfcbf5eE0aDdbd8EAC3Ea74f13Ced	bryce.somerscales@hotmail.com	2024-03-07 11:09:02	4
31	nmardlin6896	BEBECeea1DaD3F5Be44EABbdfEAa16bF1bEdfe2EFAeBE4Ad0f9073e6c6EfA73e	nara.mardlin@gmail.com	2024-04-28 04:05:01	1
32	apoulglais43114	2f7BEaEBDbe093daa2AAdd8D8fE6126EeBc5034BebFAEf7F4AaeEdbeCD5dFEc5	alana.poulglais@gmail.com	2024-05-10 18:19:41	2
33	abossom1220	C35bAEdcEd46fBb3320FCAFbc69d08dCE0A4D4C8ed7fbaCBBb6eDb0D45Ea9aae	atalanta.bossom@gmail.com	2024-11-15 02:08:20	5
34	msaker63135	902Fe289d47Cb37FBd8aaB4cEB9dEde8d4bcbe51fede1Afd7f16FAdeb887BfCB	meier.saker@hotmail.fr	2024-03-22 20:17:46	1
35	phulme57174	962cc1FDaD1cDf7C06f67Cb975b34bDeBe64e75bEFb83cdDB0DA5fCbD193afBC	paola.hulme@aol.com	2024-04-29 11:12:31	5
36	dloughran16890	AaFBcDC5d0F98Ca82CAB1d78Fc6AfCc085ECDCecBb08a0Cbab1c5Ac6ad1daE5e	danielle.loughran@gmail.com	2024-08-04 08:48:19	3
37	bdusting1790	5ecf4BEA0823BD5Eac1B7d0b0D38DA30DEfF4D55fDFFbeC20ac604Dcc8eaB60F	bellina.dusting@mac.com	2024-02-20 14:46:39	3
38	lstoneley3619	b9CECD1F151ACf87B36dadFCcaF5B356Fa5951D7A9578e3FEabC6F2dcE35CC3b	lynnette.stoneley@gmail.com	2024-07-04 01:13:20	2
39	bmaccollom9029	Cd997E02F5e0D5F8DFf39B1E0dDa40b18767e1BECe3bfCFBd3f0dbddEFaA2bDb	burnard.maccollom@gmail.com	2024-01-21 19:00:07	5
40	gkennsley65082	92Bb66feF9d8Efe3EEC2Ad0A4Abe2cabAdAbB2Adff77DBDbce2aA0ECcEf6ebdd	gennifer.kennsley@facebook.com	2024-08-16 03:32:45	3
41	jcoxall36903	aA4abcdaaEDdeFDBfdCbd261ccedd8c7aE6bE88C9e1bcEC060AeB9CeDAA7AAfa	julietta.coxall@gmail.com	2023-12-13 19:14:13	2
42	gpawlicki57164	dd9d4BfEdb0Dcf4ED5A3DE1cedaa9a701809Ca42FfcDdE7FCC90fE6beC44Aed4	glyn.pawlicki@me.com	2024-03-03 17:39:50	4
43	obrager62150	0D00DFDcC72AEc27C089045Fb47DaD3F5f41928B2babf9Eba0Acfff5d1AE0bEE	oliy.brager@gmail.com	2024-06-05 06:08:00	1
44	fmycroft1603	bD193cad5D4BDaFdcF2d9FAbfe94dBa2D94cacbfe2fEaBDFbF9bc7CECCeBCf2F	frankie.mycroft@gmail.com	2024-09-29 01:12:22	4
45	lsadlier19674	0a0566222DDcD9eba3ee436A7fde9178FebEF67A39BE00E42bAE527dAA18ca4A	lev.sadlier@yahoo.com	2024-06-25 15:23:23	1
46	ebelfit16708	e059Beacb97FeE28aFDAf053cCC1B9Ae5ae14EDb9edBD4EbCeAdf8BCb5ACf7FE	ewart.belfit@gmail.com	2023-12-27 11:03:44	1
47	bmuller47361	dD775De67E1Ef8DeAbCdabAAcC869b6bF4acCD8A1Aa8aebAD87bbaDCe53cCDE3	bradly.muller@hotmail.com	2024-09-08 15:37:16	4
48	hpimblett64405	Ca32AEdAbA59bdAd23cAF305EbddFcDEDe08adab0fefbbeB75ccD8fCaE2b0A53	huey.pimblett@yahoo.com	2024-05-04 00:50:42	1
49	ewegner43667	Ce8dbb876C28fDdEccfeffD62c29E8A7467F75AD4f0AfeAacafEB2ed82bDEC09	etan.wegner@orange.fr	2024-06-15 08:08:42	4
50	dnewsome44102	b77Fc8d5bA0F4E4C9Ec9ADDf15FDbaffbAeBddDaaCe5bBF8EAE62Ed7CccAB15A	daren.newsome@yahoo.com	2024-05-16 21:32:41	5
51	vcastella62881	8CeBCDAcaFcE1fF84bAFB6eeeD07AaaB1a0Fb1bCcFbAbFfDFDa98bDEe17AFEE7	valida.castella@wanadoo.fr	2024-03-02 08:14:37	2
52	hdonahue16208	AFeee96Fcb16d24ceeeAB206F0eE6399FFACf5C2fa1eCc5F1fca7cEE49AcacC2	harp.donahue@web.de	2024-10-07 05:32:23	1
9	lstanmer23608	aaB90F0abEffcdADEEe3464e07e9bAAbEFEDcC2EBAdEED3f62CCbe1fA9e8Be1E	leonore.stanmer@hotmail.com	2024-08-29 22:46:39	1
8	hiddison56499	bDe656fd33FADfeaB90FC752fa4e64aEBBe0ddBbAFdc8AfecA9a01DB8eBbE3Fe	hunter.iddison@hotmail.com	2024-02-04 01:01:44	1
1	mector29500	BcB7Be5dEe0DDFCCb72FacCdBaa10ff21295b0B2bdeb43e3AbD4544CbFCccbbB	mitchael.ector@yahoo.com	2024-03-04 19:08:27	3
2	ahuggen47376	B0D3FbdbFbA3DD3CB1A4faBa6bEeAFafbAea9b24BEdDC2F4CdBd7f4C1C96FaBa	ailina.huggen@yahoo.com	2024-05-03 11:25:46	2
53	farnely30799	CfafDCc6B96fBa65973aBdf6d1C2308DaAebDb9d26f4817BCF8aAAA33ddadAD7	frayda.arnely@gmail.com	2024-06-19 07:03:27	1
54	jbattisson23230	a4D5AFbeB51F7D6FAaeA52E06aEF118e4C49cDa2A8ddbfF8dA1dCcE8bbEbe6Aa	joli.battisson@gmail.com	2024-05-21 07:49:47	2
55	mcrann48623	abb2Fe6de11ef4AaaDc8E2D3B4E6FFeAf902bdfaeFDF9cbe0CEDf1A41aEeA6B8	morlee.crann@hotmail.com	2024-02-02 16:44:30	1
56	vcadden3156	A4fBaAA6C2CD4dDefEE6aFCb0e9b0BCDB59eaA1B3b38eEcBcfcdDF5CAE2EA903	vin.cadden@orange.fr	2024-08-06 02:05:04	5
57	lvescovini16640	56229FaC4bb9Fd161Bb4c0Fd3DBEef5e1aE91fd0Ab6dfD8ceD5ee9bC521Ca4Af	lilla.vescovini@yahoo.com	2023-12-30 00:29:46	1
58	tlohde9716	06AACD8f04AaC7F9d603a5B4EfFB28E0ab0dD57fCd8ECfDFFf03efffaaec8beB	teresina.lohde@yahoo.com	2024-07-20 01:18:40	1
59	nwilshere18470	9FdAA14CEDEa64fDdccc064405Ecd1b2aBA8B0eED7eE9603389aaDafAEd69AFa	nerta.wilshere@hotmail.fr	2024-09-08 05:06:05	2
60	ksteeples33094	f5BbaAcF13d439dCe0EA4a7dA75D7cABbEFcb1abBDbF0bEDAb5c69CeAB91CEFD	korey.steeples@yahoo.com	2023-12-14 13:57:28	1
61	aconstantine27997	8f8fDfFF2aFCddda2e5eaf1Cb3bACdbfDDfE1CdA349E95dEFd8FfeDFC4f1db9b	anett.constantine@gmail.com	2023-12-29 05:39:21	2
62	bvideler36454	Dd0C9EFfFdb7FE40e6FbF5dEB2d3Be7AA4Ed93F420A4FEC2DEeDCAE6eCDcBe57	brantley.videler@gmail.com	2024-01-10 11:10:11	4
63	rbolus30942	d7c6b07FB7DAa02DabdfCFAdfFd08deeBE33BFe6bEE42Bfd4f6fCDa46F0cCD7a	roscoe.bolus@gmail.com	2024-07-18 12:11:36	4
64	dappleyard8162	8647Cfda3c7E0eCC8cA37d6a6FC6966aEffE55eFae7FDBEDFaDB6AdA3bdcfeac	dionne.appleyard@yahoo.com	2024-01-12 00:39:04	2
65	lgregoratti24879	F76cfAAE8BDdEc01cB11889CD9Fc92bABd5F7Fbf8DbADAcDbCE91CEfFbAcFa1d	linn.gregoratti@yahoo.com	2023-11-27 12:55:13	4
66	berni17455	4CeAD3A5D71c8fFbebcBfd28DC13Ac9ABa6dBEB48EE12fFAFE4CbfC0F7dBE4CE	bertram.erni@hotmail.com	2024-08-13 18:51:17	2
67	sarling14702	656CcacfAA8ea21Fb0cC9FbEbfbDE009bcD9FEafcdA6AABfAF3707bA8015EeeD	spence.arling@web.de	2024-11-07 07:39:27	4
68	fmore63646	CbB0CEeFdce06bfdDdE6b8bfebAFf36bF86858bbd4a6ccfdED8eCdcF1dAc8A2C	fin.more@yahoo.com	2024-07-22 12:19:43	5
69	keggar29436	BA5bBCDbcc77D6E2ECc8EC8cDBd6E60FeF6DcedF161C014cFa71cCfaAEbE0f4C	kassie.eggar@yahoo.com	2024-10-05 00:41:21	2
70	bwolland19479	56db7Baab2A2FeaF5EF9bE6aB31E6d0cfF9f7d0dDb119eDCCaeD75CfDB1D175D	bethina.wolland@yahoo.com	2024-01-15 19:40:38	3
71	wrosel30448	cbaec7E2D1B9de6c6F44dBD3880b6fFAAc0bACbd3ada37Af3A63FEe2aEc0b9C1	wilbert.rosel@aol.com	2024-02-23 01:17:50	1
72	cdytham44071	FDE1aaFBf7e22159F736FAEefA7e9Bb5BaBFC22CF48A3db1DbCdcE2cECFDC6ad	clarette.dytham@yahoo.com	2024-11-19 14:23:13	1
73	hnorrington49040	CecF6A2faaec9ebCCf1d4be72CD72FE6cf50CEC951eFEABDD8BC8D5db41EE03D	herold.norrington@yahoo.com	2023-11-30 17:20:25	2
74	awasbrough49152	7CC79eBeF0D31FAfa6dEF6BCa0ff53ae3F7e8c067d1AAFD5f0ecC3aEEAaf596f	anica.wasbrough@yahoo.com	2024-01-11 04:27:41	2
75	sspaxman19449	bAaB7ee1aa716aEeC0cEafD2ed7e744CFcebD0D8bCfb4eDBDec9A2BdEabe8dcd	solly.spaxman@gmail.com	2023-12-10 22:29:16	3
76	bcharte19628	CFeBF4A3eddEAaC9Fedb8E953F5ad5cEEf5821aAEfAceeDce8DaabdAFDBC6c38	barbie.charte@yahoo.com	2024-02-03 10:55:56	1
77	njakeman33883	7fEF8AAEe7AEe1b4BEd9B8aff06D80fB2cfDFC75CEb5A95Dca2faf6fD8AE1a6c	nefen.jakeman@yahoo.com	2024-11-01 12:42:29	3
78	kbautiste3349	4dA6C6fe20b88dDfA554BA9BcaA7dAce43dA20f05CB056bA8a3fE02e0054Fb6f	kellina.bautiste@gmail.com	2024-11-18 04:39:09	1
79	mmark25045	Bcae82De3da0af7A6edE4DbC0Dc0Bbed8dCCaea53FA9aDB2FedC3F256CBfc8Ec	meir.mark@gmail.com	2023-12-28 02:00:38	3
80	kpowe40192	BBB65dB983AB1CbbaEaAaCFd507A9E0999613bD2FC4beaf4fCdECdda49996Ce0	kerrill.powe@hotmail.com	2024-06-13 19:46:10	2
81	nrodrigo13907	8cCCAd68E1E4DB43d89cEC8dABDeceCcf68ea66AAffBDadBbefACeaf1A9a1bBC	ned.rodrigo@hotmail.com	2024-11-12 09:00:50	1
82	nbarnaclough27186	ECb051aB95aF9bDCecf6FF1Cb1efcdBa5AC1fBB8cAE3E6bAcDedb95bff72830A	niccolo.barnaclough@yahoo.com	2024-10-04 23:21:03	3
83	lgoodban56906	b8e6faefbC7aBfDcCfea2EEcBEecda5adAD70D9E5a49DbEcDEBBcDB6f5e8Edaa	lemar.goodban@googlemail.com	2024-01-29 08:04:30	3
84	sdobrowolny18209	AaFB0d61cbDa3f5AB846effcCe2fAFCd7ECfb601c98c9FfFeBB2E9EceBa9b26e	stanislaw.dobrowolny@yahoo.com	2024-11-01 19:38:06	2
85	dfrangleton39840	8E7fF8D6E3bEfd6B5ACfeaAD342A0fdd1eCAEFdeB2F4CD8B38cFBE6edF4A7A4d	dodie.frangleton@yahoo.co.in	2023-11-29 16:13:33	5
86	edyett14707	c8FFF9fA0e57d61DbBe1a24DCAb6EdFd781faDAfbCb88eBdAECE0e2dF866Ae9f	effie.dyett@yahoo.com.br	2024-04-12 08:02:45	2
87	igradley55898	dBAceFdfef9E6Eeceb26eFFCb5F4DD8ecFf36E6FbfDe8fbFBaB6FCc3c889DDdD	isa.gradley@yahoo.com	2024-03-09 14:22:11	3
88	pkilford42445	5A326f15fE837b3F1DDaEFB4D5EDACeCDaa0EA3bAFcCD46FFAAbb68F21A9ffa9	pen.kilford@yahoo.com	2023-11-30 07:05:00	2
89	jaykroyd19408	EF1cc6bbcE90DbffaB8CBE5C799AbCaEC6FCB75BaDD2c4BC6f30eE8c7F3a5dBd	jermaine.aykroyd@aol.com	2024-02-22 00:55:22	3
90	jhayden6501	4cD2ea68dfdAE8cbeCafbECccFDCCaaae0c0a2fB0A2BD84eAF618de88D701E45	janine.hayden@yahoo.com	2024-07-15 22:49:25	2
91	rbarstow22224	fa2AbBabeFac1cffaFA31fB2bF37d38C4d0AbdF4FBa30BEfE56CdACFDa15ba51	royall.barstow@gmail.com	2024-08-11 05:26:38	4
92	rlindelof41672	abe9d26bFB7441CE0aab1CeCB3B5cb343f0A33ee6F6fEA2CfD6f1eDf9eCfdA5c	reg.lindelof@yahoo.com	2024-03-05 21:51:39	3
93	ecosker35288	afC4340aa6EBdA9eC75EFF0Fb7CcdcaF8eCe146cb7b496f1dEbDE9FaAB3e8d8E	evanne.cosker@yahoo.com	2024-11-14 09:56:54	2
94	sfalkous10418	0EC2fa2bbAee48BAbd3C9CaF6D7C5F34c90cEedD0DbaB3b1f0c0Ba2CDDAfba6a	seamus.falkous@hotmail.com	2024-07-21 14:20:34	4
95	eheningam27983	3dfDE6Cabeb274eAE615Acd60cfCfe7AD3bB1Efff2F3E964aAcaDead0afD1241	etti.heningam@yahoo.com	2024-03-03 05:49:53	2
96	wgoney33338	b4bA8bA5a24D9dF6fEA2d2Fbc82fFAfAD61eC12E2bCeAF9dfCCB08F3B7Cb3D96	whittaker.goney@hotmail.com	2024-07-24 00:38:25	2
97	akeiley10304	4c5d3dB6cFEFAb6b9aA680Caeeff9eACFaA1603eeBcCaAbf0ABEaafEFD9C72DC	amalia.keiley@yahoo.com	2024-09-01 01:32:14	2
98	bdrewett32662	7fBafa9f5cAb7eECBBC7e020dcbcDd4Eccc5aba1ecDddDceCdD85Ddc7D8e94fC	billie.drewett@gmail.com	2024-11-05 21:40:30	3
99	mspeddin60485	EcfaccDE410b4Bc19ACCDCf8D3EDbbBDfF6A9eBECBB0c961BdECDcB7Fd0B7aD3	mendy.speddin@gmail.com	2024-09-30 13:30:59	2
100	fdanher32411	eDdFCCCC3FFDC7A8A66a8F7AcC3aeb994B560E7a3b3cA2D1013CfD3ECef80cB8	fremont.danher@gmail.com	2024-02-19 05:50:55	2
107	olzhas	$2a$10$GjO4BFW7zSV5TBkVD6dvIOCjZlt2ODqgl.739GpXIRRkP.yQNpFiO	olzhas@kbtu.kz	2024-11-21 13:38:56.013822	1
108	bekarys	$2a$10$q9aJQxWk5dnsK.w1n2UJqOC1wSlI/98UHD6h0zf1Detpk2JWULnUW	bekarys@kbtu.kz	2024-11-21 15:16:41.954881	1
112	john_doe	hashed_password	john@example.com	2024-11-23 22:16:54.458769	1
111	zhanel	$2a$10$3YtdbUyS.cKNd/q4.JCwxelTFhxsi5Qh/CysCNVdflsyxV9Kzvq3u	zhanel@kbtu.kz	2024-11-23 22:09:17.333175	5
113	sultan	$2a$10$hGYlC26M8bcUNgQ9gCt2melB6EnVirLdcGPfNpx6ZzaHZ5Gxxib56	sultan@kbtu.kz	2024-12-01 03:29:26.2853	3
118	sulteke	$2a$10$9.wMLRwnjfa55Z/GrYhede3zg0lov1T9ZyNlafgOEqoWfYcQyUtaG	sulteke@kbtu.kz	2024-12-01 03:34:07.988878	3
121	admin	$2a$10$stEeLEvmtkK3ZdzAbtPKC.iLeS1oo6P1DDxPXAnb1NfrWu709g0Ve	admin@kbtu.kz	2024-12-01 04:23:57.970271	1
119	o_saduakhas	$2a$10$232NgrD0snCVrxopwTvEE.PcgxuaGiEYZi2jQVOInkq2z5AdqU8Ie	olzhik@kbtu.kz	2024-12-01 03:39:09.251489	2
120	tasherok	$2a$10$ehnWZspbv.J7/6xhEyF3ie8SIAKl9hQfw5duCg57KIzRkRlelgIj2	tasherok@kbtu.kz	2024-12-01 03:41:59.325716	4
124	bekarys123	$2a$10$U/SJGaqYYFlf6XHZggeNtuvn.iGAJFl3Z04U1G.iIIDemV5T3tCdu	bekarys123@kbtu.kz	2024-12-03 15:06:08.099214	5
\.


--
-- Name: auditlogs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auditlogs_log_id_seq', 100, true);


--
-- Name: cartitems_cart_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cartitems_cart_item_id_seq', 123, true);


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 11, true);


--
-- Name: orderitems_order_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orderitems_order_item_id_seq', 116, true);


--
-- Name: orders_order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.orders_order_id_seq', 114, true);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 105, true);


--
-- Name: productimages_image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productimages_image_id_seq', 102, true);


--
-- Name: products_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.products_product_id_seq', 103, true);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 105, true);


--
-- Name: roles_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_role_id_seq', 5, true);


--
-- Name: sessions_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sessions_session_id_seq', 100, true);


--
-- Name: shoppingcart_cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shoppingcart_cart_id_seq', 102, true);


--
-- Name: useraddresses_address_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.useraddresses_address_id_seq', 100, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 124, true);


--
-- Name: auditlogs auditlogs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditlogs
    ADD CONSTRAINT auditlogs_pkey PRIMARY KEY (log_id);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (cache_key);


--
-- Name: cartitems cart_product_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems
    ADD CONSTRAINT cart_product_unique UNIQUE (cart_id, product_id);


--
-- Name: cartitems cartitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems
    ADD CONSTRAINT cartitems_pkey PRIMARY KEY (cart_item_id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: orderitems orderitems_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_pkey PRIMARY KEY (order_item_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: productimages productimages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productimages
    ADD CONSTRAINT productimages_pkey PRIMARY KEY (image_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (product_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);


--
-- Name: roles roles_role_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_role_name_key UNIQUE (role_name);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (session_id);


--
-- Name: shoppingcart shoppingcart_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcart
    ADD CONSTRAINT shoppingcart_pkey PRIMARY KEY (cart_id);


--
-- Name: useraddresses useraddresses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraddresses
    ADD CONSTRAINT useraddresses_pkey PRIMARY KEY (address_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: auditlogs auditlogs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auditlogs
    ADD CONSTRAINT auditlogs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: cartitems cartitems_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems
    ADD CONSTRAINT cartitems_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.shoppingcart(cart_id) ON DELETE CASCADE;


--
-- Name: cartitems cartitems_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cartitems
    ADD CONSTRAINT cartitems_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- Name: orderitems orderitems_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- Name: orderitems orderitems_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orderitems
    ADD CONSTRAINT orderitems_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- Name: orders orders_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- Name: productimages productimages_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productimages
    ADD CONSTRAINT productimages_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id) ON DELETE CASCADE;


--
-- Name: products products_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.users(user_id);


--
-- Name: reviews reviews_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(product_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: shoppingcart shoppingcart_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shoppingcart
    ADD CONSTRAINT shoppingcart_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: useraddresses useraddresses_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.useraddresses
    ADD CONSTRAINT useraddresses_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: users users_role_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_fkey FOREIGN KEY (role) REFERENCES public.roles(role_id);


--
-- PostgreSQL database dump complete
--

