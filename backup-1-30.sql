PGDMP     6        
             }            attendances    15.1    15.1 :    A           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            B           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            C           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            D           1262    49241    attendances    DATABASE     �   CREATE DATABASE attendances WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Philippines.1252';
    DROP DATABASE attendances;
                postgres    false            �            1259    49338    Activity    TABLE     `  CREATE TABLE public."Activity" (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    "activityName" character varying(255) NOT NULL,
    semester character varying(255) NOT NULL,
    "acadYear" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public."Activity";
       public         heap    postgres    false            �            1259    49337    Activity_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Activity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Activity_id_seq";
       public          postgres    false    217            E           0    0    Activity_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Activity_id_seq" OWNED BY public."Activity".id;
          public          postgres    false    216            �            1259    49347 
   Attendance    TABLE     R  CREATE TABLE public."Attendance" (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    "StudentId" integer NOT NULL,
    "ActivityId" integer NOT NULL,
    "yearLevel" integer,
    section character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
     DROP TABLE public."Attendance";
       public         heap    postgres    false            �            1259    49346    Attendance_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Attendance_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Attendance_id_seq";
       public          postgres    false    219            F           0    0    Attendance_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Attendance_id_seq" OWNED BY public."Attendance".id;
          public          postgres    false    218            �            1259    49375    Enrolled    TABLE     q  CREATE TABLE public."Enrolled" (
    id integer NOT NULL,
    "StudentId" integer NOT NULL,
    "yearLevel" integer NOT NULL,
    section character varying(255) NOT NULL,
    semester character varying(255) NOT NULL,
    "acadYear" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public."Enrolled";
       public         heap    postgres    false            �            1259    49374    Enrolled_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Enrolled_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Enrolled_id_seq";
       public          postgres    false    223            G           0    0    Enrolled_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Enrolled_id_seq" OWNED BY public."Enrolled".id;
          public          postgres    false    222            �            1259    49364    Setting    TABLE     S  CREATE TABLE public."Setting" (
    id integer NOT NULL,
    "activeSemester" character varying(255) DEFAULT '1'::character varying NOT NULL,
    "activeAcadYear" character varying(255) DEFAULT '2024-2025'::character varying NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public."Setting";
       public         heap    postgres    false            �            1259    49363    Setting_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Setting_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Setting_id_seq";
       public          postgres    false    221            H           0    0    Setting_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Setting_id_seq" OWNED BY public."Setting".id;
          public          postgres    false    220            �            1259    49327    Student    TABLE     �  CREATE TABLE public."Student" (
    id integer NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "middleName" character varying(255),
    "lastName" character varying(255),
    email character varying(255),
    "idNumber" character varying(255) NOT NULL,
    "rfId" integer,
    "photoUrl" character varying(255),
    "yearLevel" integer,
    section character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public."Student";
       public         heap    postgres    false            �            1259    49326    Student_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Student_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Student_id_seq";
       public          postgres    false    215            I           0    0    Student_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Student_id_seq" OWNED BY public."Student".id;
          public          postgres    false    214            �            1259    49402    logs    TABLE     �   CREATE TABLE public.logs (
    id integer NOT NULL,
    level character varying(255) NOT NULL,
    message text NOT NULL,
    meta jsonb,
    "timestamp" timestamp with time zone
);
    DROP TABLE public.logs;
       public         heap    postgres    false            �            1259    49401    logs_id_seq    SEQUENCE     �   CREATE SEQUENCE public.logs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.logs_id_seq;
       public          postgres    false    227            J           0    0    logs_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.logs_id_seq OWNED BY public.logs.id;
          public          postgres    false    226            �            1259    49389    users    TABLE     �  CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    "isVerified" boolean DEFAULT false,
    "resetToken" character varying(255),
    "resetTokenExpiry" timestamp with time zone,
    role character varying(255) DEFAULT 'user'::character varying NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false            �            1259    49388    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    225            K           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    224            �           2604    49341    Activity id    DEFAULT     n   ALTER TABLE ONLY public."Activity" ALTER COLUMN id SET DEFAULT nextval('public."Activity_id_seq"'::regclass);
 <   ALTER TABLE public."Activity" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    216    217    217            �           2604    49350    Attendance id    DEFAULT     r   ALTER TABLE ONLY public."Attendance" ALTER COLUMN id SET DEFAULT nextval('public."Attendance_id_seq"'::regclass);
 >   ALTER TABLE public."Attendance" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    218    219    219            �           2604    49378    Enrolled id    DEFAULT     n   ALTER TABLE ONLY public."Enrolled" ALTER COLUMN id SET DEFAULT nextval('public."Enrolled_id_seq"'::regclass);
 <   ALTER TABLE public."Enrolled" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    222    223    223            �           2604    49367 
   Setting id    DEFAULT     l   ALTER TABLE ONLY public."Setting" ALTER COLUMN id SET DEFAULT nextval('public."Setting_id_seq"'::regclass);
 ;   ALTER TABLE public."Setting" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            �           2604    49330 
   Student id    DEFAULT     l   ALTER TABLE ONLY public."Student" ALTER COLUMN id SET DEFAULT nextval('public."Student_id_seq"'::regclass);
 ;   ALTER TABLE public."Student" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �           2604    49405    logs id    DEFAULT     b   ALTER TABLE ONLY public.logs ALTER COLUMN id SET DEFAULT nextval('public.logs_id_seq'::regclass);
 6   ALTER TABLE public.logs ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    226    227    227            �           2604    49392    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    224    225    225            4          0    49338    Activity 
   TABLE DATA           n   COPY public."Activity" (id, date, "activityName", semester, "acadYear", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    217   F       6          0    49347 
   Attendance 
   TABLE DATA           {   COPY public."Attendance" (id, date, "StudentId", "ActivityId", "yearLevel", section, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    219   �F       :          0    49375    Enrolled 
   TABLE DATA           {   COPY public."Enrolled" (id, "StudentId", "yearLevel", section, semester, "acadYear", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    223   RH       8          0    49364    Setting 
   TABLE DATA           e   COPY public."Setting" (id, "activeSemester", "activeAcadYear", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    221   �J       2          0    49327    Student 
   TABLE DATA           �   COPY public."Student" (id, "firstName", "middleName", "lastName", email, "idNumber", "rfId", "photoUrl", "yearLevel", section, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    215   BK       >          0    49402    logs 
   TABLE DATA           E   COPY public.logs (id, level, message, meta, "timestamp") FROM stdin;
    public          postgres    false    227   �T       <          0    49389    users 
   TABLE DATA           �   COPY public.users (id, name, email, password, "isVerified", "resetToken", "resetTokenExpiry", role, "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    225   �T       L           0    0    Activity_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Activity_id_seq"', 3, true);
          public          postgres    false    216            M           0    0    Attendance_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Attendance_id_seq"', 25, true);
          public          postgres    false    218            N           0    0    Enrolled_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Enrolled_id_seq"', 51, true);
          public          postgres    false    222            O           0    0    Setting_id_seq    SEQUENCE SET     >   SELECT pg_catalog.setval('public."Setting_id_seq"', 1, true);
          public          postgres    false    220            P           0    0    Student_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Student_id_seq"', 51, true);
          public          postgres    false    214            Q           0    0    logs_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.logs_id_seq', 1, false);
          public          postgres    false    226            R           0    0    users_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.users_id_seq', 1, false);
          public          postgres    false    224            �           2606    49345    Activity Activity_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Activity"
    ADD CONSTRAINT "Activity_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Activity" DROP CONSTRAINT "Activity_pkey";
       public            postgres    false    217            �           2606    49352    Attendance Attendance_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "Attendance_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Attendance" DROP CONSTRAINT "Attendance_pkey";
       public            postgres    false    219            �           2606    49382    Enrolled Enrolled_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Enrolled"
    ADD CONSTRAINT "Enrolled_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Enrolled" DROP CONSTRAINT "Enrolled_pkey";
       public            postgres    false    223            �           2606    49373    Setting Setting_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Setting"
    ADD CONSTRAINT "Setting_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Setting" DROP CONSTRAINT "Setting_pkey";
       public            postgres    false    221            �           2606    49336    Student Student_idNumber_key 
   CONSTRAINT     a   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_idNumber_key" UNIQUE ("idNumber");
 J   ALTER TABLE ONLY public."Student" DROP CONSTRAINT "Student_idNumber_key";
       public            postgres    false    215            �           2606    49334    Student Student_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Student" DROP CONSTRAINT "Student_pkey";
       public            postgres    false    215            �           2606    49409    logs logs_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.logs DROP CONSTRAINT logs_pkey;
       public            postgres    false    227            �           2606    49400    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    225            �           2606    49398    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    225            �           2606    49358 %   Attendance Attendance_ActivityId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "Attendance_ActivityId_fkey" FOREIGN KEY ("ActivityId") REFERENCES public."Activity"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY public."Attendance" DROP CONSTRAINT "Attendance_ActivityId_fkey";
       public          postgres    false    3219    217    219            �           2606    49353 $   Attendance Attendance_StudentId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "Attendance_StudentId_fkey" FOREIGN KEY ("StudentId") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public."Attendance" DROP CONSTRAINT "Attendance_StudentId_fkey";
       public          postgres    false    219    3217    215            �           2606    49383     Enrolled Enrolled_StudentId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Enrolled"
    ADD CONSTRAINT "Enrolled_StudentId_fkey" FOREIGN KEY ("StudentId") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 N   ALTER TABLE ONLY public."Enrolled" DROP CONSTRAINT "Enrolled_StudentId_fkey";
       public          postgres    false    223    3217    215            4   �   x���1�0E��٫D���4[%���%omR!��4KQ����)F��q�1D��*��Ini�m�2�â�,�)����E�#:��P�����j1��6��·V{���"���ԧ,���Y��dQ����MxM~"8[ x ��G�      6   �  x�}�Ar� E��)��D�$���)z�s���~�y��l��IZ������w��l���)��H���ڑ���{��YO"�_����a>Rf{�3~�0�<Ci,{{��8��0"���\c��CZ�De+g�p>$�h�~�⬬�����^JL�8|HQ[��.�;Fԯ�L�m��h���զ���T��w�H��!�2} �����"=W�>$�H��vZYZ�%�	#�����������~h�g6��0"�Zکr�-�q�p0"Y�T�y����O��0"YQ��Κ~HF$��j/q>g�q��0"]�Tk�
f��\F�����G���x���jaf�sgp�p0"]��
=v�1��颦ָ��6���`D�(��n��5��!���7D?LD�\���      :   �  x���Kj&1���)�b��-�r�����f1C�AЄ@���RYM@��E����3����}v�d�`zD�Ʀ���#�c�tiL+$�_|DI������A�~(h`E�ʕ�%�0���WԖ����yGm	�"ʯ�WA����t=UJH
��`wV������wL	i�8U��-!-�b��O�%��S��y�m	9������U[���Ɔ�'��Xw_l	y��T`ޯK	9��L����H�ኢ1��
�
�P&�f��" �n�]���a��H	UA��X|��P�����L	u�3c�3#%�Z�Ʋ�ɶ���������}��մ)aجx+�b�Ȳtm1�`�X88P��?����([���+�K?m}ؚ�NE"�b��:�t��y�1P5��!�Ş�{�h K6�c�	��ҁ�;����x��+�Z��k�����D�Z�����d*M=OYQ�����C��mf�R���!�Pޯ)R���a�>c�c)
RL?-?�O��9�b ���������w� ����3`�M��l�T�9O�*7ҝ�� �%�KLg|C�k.�꒱>����:��A�>;EP��g�;5>�7I?t3`j�=a���%�%C�!�@�%�A���0�ߨon�����uڥ&�:�}7D�`|�_      8   ?   x�3�4�4202�� ���������������������������������P�+F��� �!      2   ~	  x��Y�R�H|.}��7p��t�Ӗma���ͬ�yF2��!�=��4?6Y���XTVDAs:�t�<�y�M����.���_��H��DI�J6���E�\���~��e5�6{��2~E�����X�a��Ժ���:��̛l��������Mnb�!��~�"�,IE�d�Gyx}o�}s���Cӥ�,[	�+i%wi���P��q>��2ℤI$2�i�}~��c�֖�cQ��!���]�ࣀl�ԕ4� �: �x���<a(����'թ�S���8���=�1��w%�'���&�"�dE�I��ӄl��h���˺�5��_�P�j�!�e��G���l��
��)�'�:d�[���H��5�#!_�Ǆ� d_<U��|��f�g�^���|ʀÒ5�d7A���|�ȿ��"�0x�� !ȏ�-��kٖ�  ��3 Ǽ�tY��0�NdM��퍈3�+�u4�O��L6���v�{��CQ˟dˆG��d�ޙ@jL�5�ɜ2kb�]��[Y}k�g�P⸖܃$��g������r��q�;�$�Ư_�\��#sw���dYbS�M)���(�AK�,�Aܻ "3���s��:���Pu�V���l͗�0��k�����sI�pl�"^�8���J�}���6o��~)�|ɷ���a�T�rb��|.i��ȝ��u�"b�X���|��N㿟�mC \w��ѕ4��"�~���S�G��U*�.�~��cyS8�b���49[N�o�ʶ$�8~F�9;�}�#�
c�:����(=�/i����\�	Ƀ���$]�IU��u��i�'Ť�*�C���K�E�I�c`iB�������ٽ6��h�P��q��%���l:�Xd7$�k�,1���:?��`T��bep�=�)M�/i�Cn�&����f<���ce�����3��=�)4|�Ww��]�H��?e��\��`V���XЏ}�V�1:(MA��b}I�9
 �<Ȣ &7~�xy%�Z�u����i�:�1��fJ]Ic�ؼ���}��p�"{ٚ��!�
^��r�8����1N�ͣ@Wb_&�9D*$��4A$'�x�g�)-(Ƨ�Uӳ+i�$��AoO	#
(a/� ��j��P~��3�Ra���ܸj�v%���󻍞"!f�p&L�A���^|T���D�*�Qw����Ƥ�����:�p�����#>���?C����l��8����bQkY_Ҡ�"
B�s��=� �I5鐔��f8Z����L�����v�pxp���"��oe����X���F]�����K����0Y�S�G��%�����5��>��[�2XkT[]s �.iP��M?81��i'��E�߾����W������bk���I�2ً.��<|�-s8m���rha�\��C|p�_���S��X��m0�R��J�ɼ.Nu�-GeT/<�ޮYo�F?c_��г_Np7�N���A��45�y��ۉCGV���l'�=�fo��4����Mʷ����)W �7�������֔b��{󇎊�0���L̓��D	D���m�ݶ.�S���g0=_/$�a0̝�^7�F��a�������B7��x9aQ*��pi��/���9�nO��s�f	7��ol�g���礬�m�~�w��p��0�.�� fNx��,�e1�G�[��Z����^�>G ۗ_3XB>wؔ�|�7|&���=�!~�9[j$f�x)HQ���S��ۊ^X��y���z���A'�ēS2C_���G�!�4X"	=!�?���>n˗�R�A��p� ���г�#�i�͍aY
��������'�{����ʧ���(�
��3"���ˀ�T����Lr�ATOy)�M������^妩 q�	�2�����)��Z=�CH�Y4&>C�I�@L{ 53ݱ���ؤ�ˊ��Cw���u��]IU�҇z��������� �����FZ=�K�u�g�A�eܩ�N��2M�	vK,�C4��t|W�AV(|7ޣq����ж�Qe�>
�>�
�^��N,�o˝F�ɺ�I<S-�jNԱ�3 >r=C� ���IQ�HK��D}
�� �v�k��4�p!(�a1��5";�c�)u&��0�c�j��v�WLB���)=)~@v'l6u��T�����"��6�pFd�����1����f�u �I�ܿB��-����dͷ2�,:��S�R�r��]vjo(6 �iMX��b�|�!:�;�ڽ�'������⣀,o�T��2 �iLn�m�p�[?����Яp��M~/����>�P]�$�7�U�l�M��z=���Y����T�u�����ӻ�)��A?��_,.�����ܜP���DӴ��Yzk      >      x������ � �      <   �   x�3�,JM�,��I��y��鹉�9z����*F�*&*!��f��扆)EY�Ef����iz�F!��F���^�)~�!A��ɕ��f��z�%�1~ TZ�Z�id`d�k`�kh�`hiebbe`�m`�C�+F��� HW*     