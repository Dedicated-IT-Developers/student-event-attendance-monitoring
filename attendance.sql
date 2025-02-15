PGDMP                         |            attendances    15.1    15.1 $                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            !           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            "           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            #           1262    24620    attendances    DATABASE     �   CREATE DATABASE attendances WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Philippines.1252';
    DROP DATABASE attendances;
                postgres    false            �            1259    32782    Activity    TABLE     `  CREATE TABLE public."Activity" (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    "activityName" character varying(255) NOT NULL,
    semester character varying(255) NOT NULL,
    "acadYear" character varying(255) NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public."Activity";
       public         heap    postgres    false            �            1259    32781    Activity_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Activity_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public."Activity_id_seq";
       public          postgres    false    217            $           0    0    Activity_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public."Activity_id_seq" OWNED BY public."Activity".id;
          public          postgres    false    216            �            1259    32791 
   Attendance    TABLE       CREATE TABLE public."Attendance" (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    "StudentId" integer,
    "ActivityId" integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
     DROP TABLE public."Attendance";
       public         heap    postgres    false            �            1259    32790    Attendance_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Attendance_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public."Attendance_id_seq";
       public          postgres    false    219            %           0    0    Attendance_id_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public."Attendance_id_seq" OWNED BY public."Attendance".id;
          public          postgres    false    218            �            1259    32808    Setting    TABLE     S  CREATE TABLE public."Setting" (
    id integer NOT NULL,
    "activeSemester" character varying(255) DEFAULT '1'::character varying NOT NULL,
    "activeAcadYear" character varying(255) DEFAULT '2024-2025'::character varying NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public."Setting";
       public         heap    postgres    false            �            1259    32807    Setting_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Setting_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Setting_id_seq";
       public          postgres    false    221            &           0    0    Setting_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Setting_id_seq" OWNED BY public."Setting".id;
          public          postgres    false    220            �            1259    32769    Student    TABLE       CREATE TABLE public."Student" (
    id integer NOT NULL,
    "firstName" character varying(255) NOT NULL,
    "lastName" character varying(255),
    email character varying(255) NOT NULL,
    "idNumber" character varying(255) NOT NULL,
    "rfId" integer,
    "photoUrl" character varying(255),
    "yearLevel" integer,
    section character varying(255),
    semester character varying(255),
    "acadYear" character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);
    DROP TABLE public."Student";
       public         heap    postgres    false            �            1259    32768    Student_id_seq    SEQUENCE     �   CREATE SEQUENCE public."Student_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public."Student_id_seq";
       public          postgres    false    215            '           0    0    Student_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public."Student_id_seq" OWNED BY public."Student".id;
          public          postgres    false    214            u           2604    32785    Activity id    DEFAULT     n   ALTER TABLE ONLY public."Activity" ALTER COLUMN id SET DEFAULT nextval('public."Activity_id_seq"'::regclass);
 <   ALTER TABLE public."Activity" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    217    216    217            v           2604    32794    Attendance id    DEFAULT     r   ALTER TABLE ONLY public."Attendance" ALTER COLUMN id SET DEFAULT nextval('public."Attendance_id_seq"'::regclass);
 >   ALTER TABLE public."Attendance" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    219    218    219            w           2604    32811 
   Setting id    DEFAULT     l   ALTER TABLE ONLY public."Setting" ALTER COLUMN id SET DEFAULT nextval('public."Setting_id_seq"'::regclass);
 ;   ALTER TABLE public."Setting" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    220    221    221            t           2604    32772 
   Student id    DEFAULT     l   ALTER TABLE ONLY public."Student" ALTER COLUMN id SET DEFAULT nextval('public."Student_id_seq"'::regclass);
 ;   ALTER TABLE public."Student" ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    215    214    215                      0    32782    Activity 
   TABLE DATA           n   COPY public."Activity" (id, date, "activityName", semester, "acadYear", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    217   �+                 0    32791 
   Attendance 
   TABLE DATA           e   COPY public."Attendance" (id, date, "StudentId", "ActivityId", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    219   ,                 0    32808    Setting 
   TABLE DATA           e   COPY public."Setting" (id, "activeSemester", "activeAcadYear", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    221   6,                 0    32769    Student 
   TABLE DATA           �   COPY public."Student" (id, "firstName", "lastName", email, "idNumber", "rfId", "photoUrl", "yearLevel", section, semester, "acadYear", "createdAt", "updatedAt") FROM stdin;
    public          postgres    false    215   q,       (           0    0    Activity_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Activity_id_seq"', 1, true);
          public          postgres    false    216            )           0    0    Attendance_id_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public."Attendance_id_seq"', 1, false);
          public          postgres    false    218            *           0    0    Setting_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public."Setting_id_seq"', 1, false);
          public          postgres    false    220            +           0    0    Student_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public."Student_id_seq"', 876, true);
          public          postgres    false    214            �           2606    32789    Activity Activity_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Activity"
    ADD CONSTRAINT "Activity_pkey" PRIMARY KEY (id);
 D   ALTER TABLE ONLY public."Activity" DROP CONSTRAINT "Activity_pkey";
       public            postgres    false    217            �           2606    32796    Attendance Attendance_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "Attendance_pkey" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public."Attendance" DROP CONSTRAINT "Attendance_pkey";
       public            postgres    false    219            �           2606    32817    Setting Setting_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Setting"
    ADD CONSTRAINT "Setting_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Setting" DROP CONSTRAINT "Setting_pkey";
       public            postgres    false    221            {           2606    32778    Student Student_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_email_key" UNIQUE (email);
 G   ALTER TABLE ONLY public."Student" DROP CONSTRAINT "Student_email_key";
       public            postgres    false    215            }           2606    32780    Student Student_idNumber_key 
   CONSTRAINT     a   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_idNumber_key" UNIQUE ("idNumber");
 J   ALTER TABLE ONLY public."Student" DROP CONSTRAINT "Student_idNumber_key";
       public            postgres    false    215                       2606    32776    Student Student_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public."Student"
    ADD CONSTRAINT "Student_pkey" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public."Student" DROP CONSTRAINT "Student_pkey";
       public            postgres    false    215            �           2606    32802 %   Attendance Attendance_ActivityId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "Attendance_ActivityId_fkey" FOREIGN KEY ("ActivityId") REFERENCES public."Activity"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 S   ALTER TABLE ONLY public."Attendance" DROP CONSTRAINT "Attendance_ActivityId_fkey";
       public          postgres    false    217    219    3201            �           2606    32797 $   Attendance Attendance_StudentId_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public."Attendance"
    ADD CONSTRAINT "Attendance_StudentId_fkey" FOREIGN KEY ("StudentId") REFERENCES public."Student"(id) ON UPDATE CASCADE ON DELETE CASCADE;
 R   ALTER TABLE ONLY public."Attendance" DROP CONSTRAINT "Attendance_StudentId_fkey";
       public          postgres    false    215    219    3199               V   x�3�4202�5��5�T0��20 "mN�ԼԢ����Լ�Ē��<�RNC� a
�kd�`�hlej�gjiҏ[�+F��� �;�            x������ � �         +   x�3�4�4202�����������iX������ z5c            x����r�ȶ6z����hB�üZT�\y
p7�?�T [H�\�o��GY�з�����Mui��X�=;VE��R����ϓ�0�=$q�Fq�⛈�����Z�����f�˪�jvlh������3��L�ՄX����p��o��3����L�ox��c��d���Yv߶��l�b��4J�)�y[��bS�xu�/��C����L30�P�$
�D��gqޛF�9|��� �D��/������P�����z��c�e���oh���Ʒi4⛸,�$�x������-y��cYU���m�j�=�Ŷ��4��/`�ADY�a4��<b+�l���y��Y�x��M`�x�R>˳to�5��d��UӖk�o�j�����i 	�8���Mc6J��b�T�����*64WKh�X����n>�%��݀�2��u�l�O������#����8𗾘��n'��E�M L�F���k �l�7Z�=4�躾@c�VGyڋ&`]�a� EZ��3o�-���R!Ӡ��"kZl�I��o���K��ǃ��q���=_�5oI<��w1Zr�5�b��.�L�<��l�1�Ѳh|���O	�Ҳ�&-��0.��y��@��0�?F3�j�o��_�%�kN�]��C��/��e߆�6pBEU�}�y���D˰��G�t�;���(���&�t��A�S��7��?�X~-�h҆֗oチ˿����d�L������{�C���q�4Ȣ_&��@ڕ�h�f,D�Y���ׇBؔZF=$t�H��|��7����㌒��������U�k艬E�8��X��$%�o,J��GƫP�eQ�r�L�fK�lZ�CaX,>��Mt�L�����������h9"ӦQ
$@ �P����f��VU��@�.�M-�l�dt������vMz`�X<�q
�دۢj��~ˏuI��
\L�Tl���p�E�Y�-)D3�T4 �[�
p�G��k9��s�Z.���A�V����m���e�x�,�+1��:9�C��<i��1��A��p�UQ{G+���]��L�D�.zwy@��E(��	���w���s�g1��[�Og�7L�$��.�R�ڦ�\��CQ�Zmj��ǲ�P��Q�$kl�e)[6M%|��6sz0<�uT�jH)/t�M�Uf�=dI�]�"!-W��)�G;G��/����m/���~['N]��#�J���8N�e�����"�����
=w���$�"H��@l�S��7�8�������'^�K���b)�~"�E��ނ�A��#P"�{�D�mQ?������=�XZ �� �o�G� �«e��<8��J,���d��8"�=6Z�����(��Q������m}�xM'i�ޗ	��qD`g�`[@��`>�7Dx`X��@0�������~!)��
�If�4�ӡC-\�uz�]Yp\��M�ߣM��f`Z6������>z.�G8�/ y 'ø�0]�0�!Z��ʪ8�Q����_�c�o��V<�0�L�	��z_�����5��h	.mㄛ�9�70�I�5�(!E9D�|��
��e�\ �4Z��eІN�����D��$�b}a>A�	��<�k�1y�?�%�1יZq�e�J%��æ�i���8�@&��D2e���連%�]�pd��qY	[�[��n{������h1�b��t�7�7Z�,-�m�dV���D�,���M�ɦ�*̟W
�Z��e��,:��N�y�n>�b?d�_��Us�#_K�3Y�U�|!�|��t����k4H��(W����?��W+��袃H�
�7�'��=D���>�� }|)��>�����"�Z�Ϣ+�p]_\�al蒨݉0"�����r����#�A�F�hy*�.>���kBP�r��4w��TӵDK���G8�/��n�<JG�ĳq2�o��O�4�M��j]�t$l�ɳM?�pf_\�ʷ`�g��i�|"�}ǚ�[�Ǉk�Cﱜ+�%_˹L��
1� �U�=�<
"�]�������zF�!�˕�ׅ����C����Vԯd�����Ξz,HC��!˕��c)�
�l��c,�XΫ QX7��1}���E� \Y�q,�D����sݤ�|�'���,+H���,�o���ڧ��e]��uTnط����i
����H1{�Q�N��J-�O�~{�c�Z	�y�Z���P��]Q��Al@�n���V���m�k:2���� �"ɃP4˱��|�|C��.��sӖuA��|�o�v봀"�ȃP4~H�Ֆ&3���?��S�z(��@!�ǳ�$��YO����~�� ˦�������|G
�6�i�i���Hp3�ۘ)���DD���҂B�k(-���.~�k!'�	�#��=-��&��,N��O��!�E���,���0�j�
����W~�zzx����#_ȗJ�{����s��MA�{m�'���?�T�7��t���,>{hp�oرE��)�܀Ĭ�
?�O��}�����+�i�-��@�&s�������V��4�l�O��r�To�,N� �E	�LO8���W۪)J�Й��ǡ�ZV���q�\���%������|�p�.WWl��'4D�J��tTX��(�Aj&j�+���x�0W;-Nžϫ�O^��y_-і�"�fX���a�q�1 8bT���T����!JY�F�x�yO���<�|�1����_�0_!G����C��=|�w�ŃX�?��U�_�M��2C�YgbZF����o�4>� ��	���c5��SUЖ��
j�~)�a|6|\@��}ժx-�_��Nŕ�g�k:D-K�������(d���C"������я�i�?��P���lc��SD��a�2����W�}��L�t����	,"�0��a��U��1�����Fm�D(�%0���K�X��O��1aߋ=�3������^��j��(�	<��B搷=�����<���B���-�;ŕނ�;DuM �#�68�;H�p�w2����I��7k۲��E<55=��j��(�	<" ��J��%/�ZA�C���,�.d-�)��=d���'�3�T��%ؽ�>Ѝ�@˙;DmM`Zx,ɨ"��,[����8
G�C-���4�Cj��z�M��,��Ő�E��l��:��i�+��j�8
:�	�d�(�!6� ���u1�ق�)*�uiz/e��ؗ�2P����(�W���庩!0n���b�5|�[�z.�Y�����,����|�o3���f�m�<%�S4���Y��C\&$U�LUd���<�o���7WJ���PU>�#fʿ� ʈ]}���8�!�w��2(�BѮ=FWoBY�ŕ㕓�>��԰�0c�A�V�ݛ���k�O�&ҕ�P9�˓G��!���!������yS��#ġ6�7ʣ�a��0'i"lʪ�7��-߮�
�O���~*����d1�1K��CPz(���>o!3�2���z���KȊ�o�k���v�e�o�z���-|�Z�C�@ݣ��P�x� ��!����s��C�{t��ks����Yfb����H+��!�-v�1ۄ���?�����#�%��Oz������d���m�]���Q\i�zU6A(rZ��ݭ�����?5T��͕Z��g��+�J$[<F��4+"��^�ŋ��Oo��J8��I01���� <�ϻpi�{O�2Ot��f)�/mY�����p�����z��0��&��g'� �_ �I��>�]��(���Tb��lg�Q6�F��<�(Jb/��r\����H���M�x�E/0� )8#\���%��!F��Ǆa":�1xj�qb8j�q��N3m�=��!�� %.���)D6�Tw�d�= ,�����_�!\�"��RJfB�1�5��b�ǯ��0�@�6����(�?bL�H�8˅��5�09WK�����TM	�($`�1�|߫�3�7DH���L-v=��iZvWW,��籯�
�e���wT޿~I�����    �y'�� @����TX����N0���3q�`䌪iژ�M�����y:�g{-!w�[�h��\v�>�K��Z���f���A��z�7˦�;Ʊ.?�+gQ?ߓ?�������p倣�#o��l��Nf�	�ʃH�mz2�8�,��L��;�!T�҂��o�8V�����VWD.a�JN|�J�ׯ1����}����A��|�NG���'��b�Jl,�����-(Q��P�Fxɢڠ���r�}%�z��hUx�:�l:���t	�k& ;m��5������eyݕod�ug�U���l�Y��-��4���`Uņ�A��.�öhI�i^n�}-:��-S�~E����*�y���	 �}VD}��bl��b	� ��4�̽�ۮt]�Գv�K

��s�fw�GPm��_1zT�b�H.��@.g�?�vG��fZj<��������Q�6da�z*NK�چ��p-&Q>��e�KPźm�;~�y���۞Z��L�a�!����|�������o�-J�@i�6�$�37Px�*�=�E�/��(R�n�	z�H�APV���VnKO��OH��QL1�� ��'�
�0*���z^�3_�pB�^!����7s%&8�t,�C,N��0��_qTrD�t��F��g�9�i��fw[���ؓ'k%���u��R^��a�Iֻ���Q���i2���{Q�����n�% S'�
U���#-��3l8��%N6C�'�; ���hew4|&�!|�}.f����u9K�F_n�+�ޖr��	�+"dh�B"���~�� �&�>Mp�x/�i�}ɷd��t4L@�ܣPP���7�9b_��������0ubQ�B�N���I��cO���.F��t����4�CS�i޽���Г�N>	I��Ԁ~�.[�$�n����`�C�k�UQ������t���e"����<�ͩA�Q�ŗ����E.�I�==�u���	P�h	�R�b��	 �w�.���ņ�ٛP��X��X҉:�������I*�"�0��#/C#0Ui� "�6��y���bxA���`ח�b��a��c��0�;�s����
�br2��d-�@��_Ia4"�C��\pƼ�n�&�� �d`p���ӱ��I�z�b�^A�5����@ ����=�i�IL�4�#]&Xu�JEsY>�q����bDre,I�w�H$�X���Eo$E���p�,曶F����r�[�l���)��1.u<Fl��o������,�|!=s��nV`�R ������߉xY'�2M=޹c"��2�!��
�B:�M0{^�pw���A�EK��t�](4R� �=����D%g�h+l�)x'υ"�bWlǽ4���12L`�g���U�qA���l9+8R�]��o����-�[�r%�Ӌ�;�.$9�e�����x�������+?M��T$�abP?~����s�ϼ��8I=���VX�����;Ni����^�5��b~-=�����0d��3E�.n���l.�]��pTL��q��Log�[R��K���{7�q"�p�G�v����&/~�cc�����P���s�sSl
���l���[�;�_G��^A��w��JG���L��5��zAU�B$Һx`u�K����_m�~X8�f�z�m@�j9 fz&�ly���E��-�|�_���K[ҋR��'&�{
���p~/U��]�3�X|p�8T�s%���H��
��<��i|�dbM"��W8�Pl��J<�g�r Q¢Bߡ����h��7jZ�*�1�j�i��?g+*T�#L��!����0áTIE���o����IT��H?�yȽ��'�)f�yz����`�u�ϲ@\WR�@K�M����ԋLM�#�f{�Y����K������й��m�O���L��{��C�Ɔ�&�BTpٰX�����soٹ����ξ�B"%���k���B��]\A�p�2�m�}��=Cʈo���f#�$��L�o�����o�_y*iu��4�B8 �����n#�sfH��C>�?�[�\δ�w5A6Qȸ߷Y��n{�h6�)DQ8h
QT��t\y���(���a߁/�|��W����ȋ������gP&��:�|�B<@H������y,��-��������+��5>���0���(�<�9�MFQz��m��զ鯪k�{f��RT��(����T�6�,�����bE|״�L�j���a�O@��s/���g��'g�5F��	�ri��DBCQ�<~�Ε%��H�4��ɗ��Yt���S��ex�I>X`0�z'��7��|�f���u��/�+t��	�V-5�@�9�o";�n�\��o�V��/��'�z/FU�����R�}'"O��G6(��G�P�iR�3��&|[F{w��nc��Ebz���ڮJ3��pv2�%�sd-d-��qRJZ�}=4��(f� s'=p�*�kV����6 ��9�+�\�ʃ$~�p*Ar�B���J��Q�̯�/�.>��5�ȡir�ĉ�#�uc�WH�`���6~���""8Dj�%��%�s�	Բi�rO�,��ğ �I^����|P�A�  ����{�n�es���P:�P�_h₡X@˗��w���� +X]]0}=G޹̢ )jw���|�í�s�f�&3̠�Cuj�$�a���59��3�����`�)d���q���Q��,3�M�Q5�#�b���q<������{��b�����We�P/
�f���p��5J�,K��'5X�?�����z��Z���*��Gs��x�����������}��{�Ljh�����j�%�00�"� w�`�&�`������3�T��H�
�,�dr3�%��N�i��P��<=�E� ���C��*v��|���We#4k{�R��	3U]C�ۄ�&��b�|����M��ES�ӕ�K3��"�|$I�o�.�|C�0��iPVxܢ*�Oe�L7Y,CO�C�udf��!n\��0�� ���ː!T?�R���6�q�,��E��կ�WZ����!�Bc3��sw;M~�nXU���~�z%�q5q\�(�ā%��o��3��/��V��[��3Ȱ7t� �G�SЖ�v�W=]m.yZ��뼎� �������4�`��7غ���JҦ'����w&���В���π����5�V噴��Ի�����,����Pn�E�Iԫ��2�{�id"b!$e��$g��6��h1�D��rx5��I4p��!����׎)B�Ŷ�]��{��DԦѽ w���`w�W�_M_ˬS�)�Z@ ���"�=>���+D���qu�D�����2��EO�	��a��k0�h��j�5���-�� �D���x�rbQs$�/ř��BS�]��C (.��x��	��Q��˚��ճ�@�Z��G��`�����}��fI�D��m��ԯ�t]�������)ub����,2�.�,2��e�+�hW����)5�o�{D��<K����0;���.�Z��_�>J������O���qI�S��]���Q&��w�g{�x�}52
�oi���K��f��p�L��� .���˦�r���\�5��&��`Brq����꣼��)����q�$8g�k�����;�C r�β���q�J�:��G�~��b�@ ��r?��������7Zl��n�k���p���,c�h- -�;~j@mj~h� ׺��� �A�� �e|��*s�>=�}��z*0Ȥ�A��"�tGT���R��Iv�4��C85f�J���YC���KX1$C<���
	@��, I8NĜ<ރ��k�a�ʕA�r��h�ǒX�U29�u3�%�GzM:��I��X�x&Kt��'=D�$ ���h�r4�Q��oĶMU�g���� �䘁e�=T'5��"%Ƕ�$�Wz��\|"H�)�����릨����V�?���n�Ij���w83��4D�*��>!.���<�;]��dѢ�9HX�%BN�~5�&�_�G��A���a=5''��ثe��Ĉ��M@zf� B�    9�K��EH�6��DC�x�D�c7y<B���!����L�7mqXA�OGT��=���d��p�K��;u��Ĕ-m���*���$i��jH��� \���at#�X:�����d$l9zևH�̏[�v�F(�SA�����O�+"g�4˓�5��-��śn�Y�+��F�
��F��W�
_���������x}��R�ޗ�$��dL
^�)`�>?��=��3D����E�O�g�~c�z��!��\�#�h�������ȯ`�.�>���o����m2��e�,e7�T��M�ޖ;:t����7?���W$���{q��y��ڑO�J_ݲ�|���P�<���k�K
u���D
Kݖ(*{������p��z��18w��_��Jh��@bW��8����I��z��E�XL��b��+z"Ĳ�>	��c~��;z��DSlYL3H#�͡����J�FO��?�����y����	� �.�}�$����X��[[;��אM�׏�q�U宨e��
����8biG@�bq
��ǐ8��w�Ϭp���Ӟ��Y�ޓu��U�d�*2�^��n�9����1�i�
� Ex̧ ��,G/�!�x�t.����9Ҫ�箎ț����
��ek~ ��l��a���d���c��j^
�z��g�~�	�����{�=`�u�M/F����h�x*M@�=V9��%Z�����U��m���z�Zz~�h�#�쾚���w,�#s��sR��,���2���K��|>Z��d���l쌵���:մ���8h�|�(!v���.�]������ў�籈.��$-���`b%��7bָ�@¶^�G��$��yxC2���\,��YU_0�\�zmj	.�2c�O@[�9x,>	
�,�� YbA��Jy@��t�)����8h�@,� ���n ?�%�m��	�v��`ϑ���i�%�8�y%Wђ^�f���yx���Q��2�U�]ޱL�LΤ+n�0��	��{��,�>� .��naZ�V�`	�D��=�=�$@o���q�r�.s���d������\6��m}%��h4P��xJtp�@�*r�Ԉs��3dF<B�����&�Za�I%�:@
Y2��a������Rl�^�Pl�/����T����u@I���������o#WmQnhFc��� ���m�7���k�?m���Y,[+_0-Z`Ԩ�oa<��e���Z�+vǫ�)��B�y���m�D��m6Y@r7� ��su.�jd�%�&1.a���|"�4\1�K���!a������f^�o����
�M��ܷ�Sa9n{�D�E�,$�*�n��������{}�X�7��k(�����w�Q��=�uɱ�F��³�N@���� b�V R�&nqҧ��r��R��=�I���g�z�O	[~ �7)B�w1+�
�U�k��A?���'T�q���a8���������L�]�KH�b��%0E��b���D���Z�Kȇ���M�Su��\.�|��j�Y,����-��I�M�$x��؃F��Ƶ���~4��k6�(a�����
����jT�0dH8l(�'��r�J�N��eo�Z���9�}p��{2�a1g�����a1���L^6�D����s,��j��3OM�qX��s9��	<%��#�<��2�rL���P!s*Z1�
Z�[:鿜�"�A0J˃w~ʿ/)+�J�V�i~��&o�U�'���ߒ	ӟ�m��H&ڶ��b�����6��Km{�x۫��?]a�\���]�!�74�#��d�{��r5JxEl== ��Hh�A4M��잋
��������]�t��`�j�`�2` �g���6$C�ېM�tJ��*�H����W6�=��^�I4e;�{?��@��uTH��O���I��`nҼ��7�����`� #�9��C�;�E{y�1R��k�K���b��K����>�v�=ۯ�A� �L�ԓh█ �LM�JW�z8 �c�'
W�g��L���8ļ���([+Ⱦ-f�E���p
X�Օ"��	�v�rC�6��on�V� ;�Hˋ�.��7�+�iW+]	�r�#�l��dx�}T��F)�B�Ck�[y䚂�i¡�]&��a��늢A��Q�Wq��WȑV����Jb�S��$����#�>/�PAO����h���SmfD�D��<,`2�nXY7��4�UF��D��2�@Ɍ�&��M! E�Ya{g���p��2�B.����\�e�a����5֯J���c�f�t��3Xh�	���L�d�
#�	��m҇h����zh����^�Ku�B(!��1��������EcսKj�f�z��� �D$rLk+��4�R}�ۜ��a�oW%�wYq����l�X�t5=9����.��4��M�˹���y�M��rQ��ԛjt#();&N'����p�s��Y�C�:U���Gi���e��)C��2UN$���)#���*c��
�����eq1M/sH��I�۴�4ʣ[���/4��{�r��fz�^|CW�<CI��|n��a���k6H�V�-��x�]d�{ÀG�7��4B8ۃP����y������I���I����ڬ?��hVeK%��g����`L%2>{����B�;E��#8�S�u[�"ݔg�YC�������q�-���Hv�3�=j�gz�����Ɠg!l3d�I��L�l**�ZB����6��	�+��'��/�^q]�فgk��!����}f�`��C��I<E���8���Wi����8�A�^@��=O�_mЂq2�z�-��xb�-"�,�͉�r÷��ƣe�B����B���b�`��2��Wa|��U��N�Ju��	�H�D��4���th�O5-Z�[�aQ��^ �V�R.�ܷ4��������䑵��MX�v���-��-{T���hO�ᤉ���fY�c1�дm!�pH(z����7�]k��a����5-�>�@|=KC�5 	T�u�2�X�"�+��������T��HrF��bҌ���&2����M��S�7�i�b_�k`�Y~�$��e�I�d�8{��u���c|9ʘ�ԔM[�p��ʷah��a%?y��M��������!���> ��E}Xw/��z�Úϡ"��@%�ݶ@����k��o��;Cx'���X�eH`������\�����No���}�W�g"�{&�� ii  8�U���W���wW��s@�0�pt��C=�{nF��� �Q�b��ݘ����s��#0��� ,zQ�4JR�x�ƗU�j���ғW�;�@����8G;���~vŋM7
C�q��� !3%;d_yԛ@��F���淪G�Ү�kޭ1����'q\"}�c�7�)�o��i &�8]_�zU<�n�5�t�F� |	�Wd,½OP\�l�Q�ƴ;O9��h X6�l>�Ѽ��Q�����/Z&q��{'��$Z����o�dj#�c�Y"Hg����벨�͡l�n��B=�F� �8����Exa � I�=�-�#�f�5t/��c��!��Wr���v�'��L��k,S�MQ=�S�����џ�A�W=�<G���H�<J���`ŗ-����'$���V�9/���O��"U+�K��s�����A��;;3М�D����Z�K����i��Y��P��Ya� �Q�/��]��So���'a�ګ�Z��%��� N�CQO�<�*�<��/VXX�~ ���CБ!9�j��ȃ�;I�����WG�n-�M=�%hy)��H�\]	�pH&�-0)�8�q^�"D����hy�vm$<y��!�3lc��,E�������I�RQ�+��"�4b�9V���<s��|Ih�ޗ V��C���'F���t��0��uU��&�BO<�~�@��B���6u���	D)x˻� 5��P��1P�PT���?�TS8K�)�K�Q7�ʨH��?�ωo��C����������"��ҍߣ����NmQ     �-��w/G3��Y/8 f|��3́REg���>�7�Bkb�@H���g{Bp �7�A���D�9.9G�0�pD r��L����3�d�|�������d���(�
Uĳ��S�cfZ9����nM�5�D�C�P�"���7M�Bp��Fb� m)j.	�x�aݝz�^�@tA��x�90��q���;l��]����P����m�E*��"����׶�QN�<⭴ ��T�� \��y�/��"q�uͩ���r>]�M9y>{���X��w;^�V���O,b�AXJ@��A�����٤�˶�d�kɅEW�d� ���&鍓�#n�L�M{jVm��#a˴4Ţ�|����?6_�&&[搊b7hW����<BZU�#�2.�.��_x�Sj��=��W'A#/�@BJ5�Я#�q3l:�xC����=�&|��@���v�����V@��>Kܻ�M�
�+$�x��e[V��ƪ��ƂO�W̱��X�}�͒q6�]`���Xզ>�r��'+�:��<]�U��w�bp���]\��/�S�m��m�&*����xͲiMRE.�c��o�u�(e��k�Z����x�V,k����_�C�5���%
��d�d��tڷ/��u�mҭW]d@�G��}rd��5õ�Hɷ�P��2r!�wc�����~jj�Q��rwvɿ@2�w��.}����CO��w���f�Hkj��<��au��4|��CC��J�SQ^F��~�q�M/��ɩ0v۔��E�_��2t�s=tD��ϟ��󢴇Ÿ�x�WX�{_ȷ���w�$�2������� �h�g�j`wP՗ C�ru��ePy
��'�-G���lҽ���QPo�=\[�3�`��U4 �eȟ�K��M��� O�	�sL���|=1�,0���)�X>�2e�!ؼf��<�!�|_ �]e�Ϧ���Zp.����<ņǾ�^ryq�kHUY���	�(� (�4��J��I������>�EYIo�|�����z �QIx��^�͓��P�1�E+�(B}B-4��@#%&4r������]"$�	�P��vD�y�(*�z���p�6C�?�  �C$g������TiQ�T�X���Ȋ�N��U)K��%�zOC� 
(�ꇎ���Ov��놴Sd�����x��B���%����F$x��}=}܊$��)U�w�@~�C0ODe�<�戽�}H]=�O�F����N{��Z3}�1%���>����8o2�#�zQ�[,�x{�'p�B�eO PO������FZ��`�^�)��(-� l��\7�a����Q�5�GS4��|n���BF��&ڸJ��0%7c�E�4�\���Cѝ%�������5,�·��<J )J��!��z>���̨����N�����v �K��%�$�Ȧ!��!x;6��֐G������|h|��,��(��,^S����A@���X{�B	���*S��v��+
����BOB�<=A&����v��\M@47�=��h�;@H��������i3#��=�~N~�-� �����%�
J�1!.bf�Gl���l����	�k�
A2�@|�*!��QO���FZj�6{ޞ���x��h"!�gS��;&&��8�<C�v>�ǩ�x:G�y%��xi�j�)5�1(�G2M9���F��b��+^!H��kK+���AD![9^�!���,��YU��Y�7��H��)�JA=�-{d��6��I&�E��U�+�p��
�ɆQ/��4��8������
��r�VMw�dځ�x��W�7�qq3GuR��K��ߩ��l�VI�!\���cX�D�/�D�|���U�B����b	J�Ԝ��_ �]\��$ Zpd��1�3i�(H�������0gZ�V�a]���Z�cL����+
��g���=��b\Q!���9x,��r5��*�T��.��y2S[��~{��
����@On�j�Ը/�	�<�#6���B��X�k��Ưe�u)=3C�8R�-Sr$��H�6f��8NR:K̆V�`'E�|$�b��$�4�	,+�s�`��B�ò�o˶�0m=�D��\�k�iy������ /�zN�ğzN��z8<�Ñ���}p�`�"Mޙ��'�^LE�m�Ts�/���z�hz9�$��~�)���Yg7�P��ЅB�f��Rz�� �H�o�[vO���������Bi����Y����z���;�ř�S��?�p���b��ѭsf.A'�nn�t^	��H�/=�g`��R_'d�X��Ӊ	��
�:Bp��K�4�����+�HJ�m�o.,}�#<��8֡0���3S���ׂE��ٟD�N��D ��r�������ާ�0�X�}�.��zP��:Pd" �b�>�R��@,�qqش�@:�=��k�25��Xd(�
ݵ�78��3��l�<V|��iu��?y�� �F�jslG^:�q	��sс΋5ǖ�_�|��� .�"~'�~�B�i��L}p4|��2f����HD��L��b��>�%�W�$�usn.��h��|��^�g����|m��L&k��6���y���|��2/x���#3Q:ǥ;H�!��Ց'M$�gD$꓄�g���Zf�,W��<�x<�%F�C�P�}� �8�q��JR�2`IZ�t�����Gq`jX���)�I�vL�%5F�>����"=1FU��.� 8���n�4���Z��^�O��L��]��Uͱl�y�n�!O�4���Z[-���x+y�h��o	����W���o%ﮦ��ֻ�QI=�(c���6b�4����g�q9��J�w� P�;��:�)R^��􊊿�KV^��X�`h�Qi��˃xy[���Da�M��O��Pu/4�xڻ��X
�=�F����D����)�@O���?8��:x�+�ނg�0d0�b�+�����52MqBv�F��8����"�wo �yC��/.R����Dnc;�)/��	��8�k-��i���`Y����\{�{�+0�� Y�d��Zg���y:�|Rrͼ�#�p�!^�r��@��"ݸk���lb���I*t9�@6FK# u�3��E��;�#z(��`��?�;(+A�S�U��'ML�/����c��&"�{��+4�#�cs9��Q ���YZ����!�A�0If��kq8uy8�[�k�
-��K���b��"Eh��?8�Ј�˝��֋����Rm�@����.�����X���z�Z�F(��!�sU�+�g�(q�!5_꽓Cˊ�\w<���R����ũ(v���5'Ne�z��ʗ���3E�l��gj�3�����> (B[�% ��F��)�D�1�6��F	T@���A,+�Hm�lP!�Qy/\��袨������	���X���,�BܯZ|�ah�����ߝ�	5��4���F JX\�ۊy����3�\>ۃeV�7~�g��-���T�$�π�&G�������I?O�԰N�g��1.D���gi�WBz����ncP�I� Afq�m�$�U�|���U��k+Nt�4}5���d��@�����|x�00��´���j[�[<�Ƹ�?"Sg7(C/1����t�^�T!:��h��FtVT(���5b�K�����@���W8Dtx���03M���������ɰq�[�.@.� mVW+.����3#�ŷD+.���Q��,�ã���yj�	W�K�7yz�NM��VXΧ��#|��� ��_��	���u�	>��@PCg��U�ᒔ`��<
��{�S��pE���|����hl�qSV�Q�G�Υ���Z=�Ӓ{I:�W����Sc!�����?�P@"0��&� $�h���/�8y].���t=٥ӡ*	���To�!�mk�/WA� o�Nj�K�u�H�xkb[}�U@���i
_4I�%hRqn�Z��q9}�	@�RN�    �;�i:�zX�̇hdp��yK{䯐���:��i���nx� ƹ�)�ZY1U����e��_`ߨU�/�mk")ҁy�G��w�D,CJz���ĝH�3��	���0�'A��G#����e�q�Z�9
ھ�
��^��	(2��X��)�������p]}���I�gB$�Mh��n�����~(�X?����5�.& (!���a��c�g Đ��*C�!�����61�		�0M�~�'a�sL��
GU~���r���6�p��U*D#�]���1��f�E��m������>��u@����,1"��:�<���|�H-p�TmGQ�ZGO���C��F�8�a:���&�YF��ݵ���C��GOw�Ґ�"�%4�A�w��٦��y�Af[�-�ׂB�!iOB��F��s����*�t�����Vj՝�W�p��%���q}gκ����X�,O@�v%�E�9���R�J�'� f�&�e��gd��)�e���O�"�1�Tj<�5N����N����s��	}��q�Ǒz��ǳ�85$�G<7�����0����K�#$��A��+�6��j�*D���`.�~�"�����g��3��ؠ.פ>��4o�j텡�0G` 7�C>��GH�v�ϒX.�P?��TG��\�`Ru�-}q�GNǀ[F�&��"��f�O�	@���.�nr��OE�V��8^�"�����i�����a	�d:���!����b��0	'��Y~b�L�P�d2���6��p�Ix�/�e�4��H�_���X3��Bvn�s�x��������{"�(B�#�	d�"4f���W_�hzY�*���X��g��ZDy ���bQ����	�mT��s;^F/�$&�[B��L{w�(e3<;�l�WbISu�;[���i����se�&��R�%�Fbvi�G�q]�;���%+>1$�8�������h.�qS�����V`��@�'a���d"����#���Q���+_Cx@ �ߠeU�Ⱥ��,-H`�9�n�#b����X�7��ˀ|��YW	
DK��X������8bԹ��1h#~���#��9�á��Z�A��11��k�x�ظ0�l��B�H�O�x Ǌ��b,�	���?�?�V\٪rM_͈]�տͧ�7�V�vh^�݊���'��E�S��|1?�L����<f��(�B�}�ϱ��۶���u�S��P��!��1�U;6�N�;���J+>�n#PI������Bq�gr���X��e��ʗ���;!ñ��ǣ<{�����ɒo���_�u�t�x��^��'&n�\�uA�,}T��a�T�	�n:ۛ��i%�>1e#pH�����x$�&� Gx�5�Y��uY�G*�@Ͼ{-���p��}d7�]�?.w�M�=��o��U�|b�E ����Q6�E�t�����պ:�ʎ������9>]�p%�y:m����35�v�/H���!?��ב8v�'��n_��L�����u��R_�?=��%E�]��?����#�b�(���1��4C����_U���iM0Dh�`�=�;� ]�-���H�����?a�`��/�g�+��.��h?�T�_��������VF;�L88�+Ş�Ps�zrDLu *>��~��h⏩Ժ|F�%�>���!���ĶD��vɾ��eq"&P�@O�<�!"i�p�(�%s���-��=�O���ꢾ ZPT!�]�'6M2�/�-��}٬p�ԡV5l-T1�U59@qm���i���\@��/Ao<�5\v�>��+���:q�F�iE�l���'g���K�����i��mJ��.�ő��|�&M�7����-�C-�3vU5PLLu��ώ�6��T]�^&��g?��6����WO 0�Mocq�~!G��7U�5���_�9}	-(*J��r������	K'`T��7�K9ӳ��(��"��e�*��4����G,�vw	��	.U�qU] Y�n�.��F��>�U�ͱh��X!�	!/z�X�C$
��Sɒ��|���շh^�f��Ŷ��<�����jT6A����ǬJ�V�D5)�4� ��Aq\��$���Fc�;��Nũ0l��0LM�|����HQ��#�����D,�d�f�mS���85��jY������<	x|u�K)L�:�Ւ���ejE!Ug���C����1�݋6�?!�h�RԜh}YZB���jj{3M��H���_ƋU՜���'oW��ߌ��2%5]���msl�>B"�{���։q%���NL��ّ�س0���ɨ���Ź�3�b����Or@fɉ��^�P�?WU���l}>�݊�`�ܠ���la����0|=��&���(.��E0���ҽ�`���Qy�Cʊ/�����ۇ�=��g�P��z� )N���KZ�l@]U<( ���p#{	��;Ӎ߱	��l==�
� �Tr㩵lH��RHEw\C֎������U36~*]i`dUp��������	��s�ˢ�<�����'v�eWpN��xۜ�C[
����r�A�#0���e�M-���y��\2(�2���rU)���JX"~�P¢$�V��B�TY�V"�u�4(ޯ�t�p��m^��ak�����ʹ=1�*�G>����(S�Q9��!=^��mw�ش=�L��T[�y��5���EYV�*���bB�2@�ov�~�h �į͎�ŏ����5�v4��^G�:S<Eb�$O��hO��y�-��w�	�<2]Uy�w�d/�KCb*�吇�=��nb,G�gG�@`Ѣ��"M�hz�����Ѫ���˯FElP�KtAT��K���~Y3��W9��gW��c�X�/[�E0M=�%X��^��Ł��@0ڋ|%�Pl[]�	�{����|05W��G�M!���8�q��cH��EU4u��Ѕ�
��,QseF��o}\�<7�w���-�M_��8��״��|�Q��fߒq/��X$���{.S��xm�NrB띡��ǣ@�����,;T�� ���2��ᴐ��z�o$�z@�8)T� ���[u51I�Vm5Լ.B���%FC���Rx&�t}'�r��`}<ѾܽT��o�`	�w^��p���C���<j�g�FK#I��ʚ�.R�;����XzH{��}���g��eB��(������0h��,:�x��$By�3������]$h+�i/�x�}�'#��u�Ӟ��~!s�0�6<�z�����d�`��9l����e��U��#|�w���! �TE���ĭb�#�����=��/v��8�b�	'��%0H�,6\��łh
�đ��8�H/E�T�W'$��_�6�^Oόl\��N����c&|�ه�,ık����<�{x�I$W�G&\��~��'���� ����V'����,0}��.��*�^���d�̐N4Z̑T�����~��cW�X	mP��.�dBZȅ���$9�Ɓ���N��"�g
�)�P�3�K���#K��Ml;ZrK�����@�����;�3Y�\�-\E�?p�׌]8-�OVCu_P��x����7���Ȭ�d��]G�R趞�P��P�W�↸W9^����=��iս����d�1��4<��t�h$R��-&�_��F/^"kD���b��n#����G�ldYzsj��j|�@+X������� �,��cD�c k&��M�imM���T���Q�P�B36�G�����Z{SO.�2�|%.β	F���	���<!�5(�y���<��a��Q�EqI ��l�����3�������H �SZjy�pO@���=O����xVn��cɱ��kE(�ާ����P���M&�\
6��A^�� ��}ǘ98ᏻߟC����!�^�I�3��DtY]�Z�;�8EP��Uh3"�P~Cx�,���<NS���M�1(������fC 1�,��#p0��rLX�������H�    Q���ô�����Z9������M���$������[��o^�%|���n��q~���hI�C�xϯ!��:+W�8Č|�M�#���g�ڲȭ}O��R��.F@�櫸u���f��,B"�P�{�-����2���l�D�v�7M�]g�1��U��T����8Fff��*N:����0��Sǵ.!)zjDm�"�ʊT���`>�p���ne��F��x�a�K45��@���p���fb-����]sh�NN��|h�	�6�,�q�s�<28�<�X�b��Mhww4l[�q�P�"R����<�8"�7$Q�׸�)6z�-����F@����Q�1J.���=9~���4}25�8���#Pr�E� ��{��4�����yg����d��e	�$KJ���%=�=�nE���S ��[�p>�7�E�Ⱥ\=,ݦV`Q���tu<^���T�+�bw�^�h���ڹf�ڞb�L �$�z���#Lc�w,��9ªh���9���[ji�M�ɵpّ���#���=2��U��To�[a�=8�pd��FX<�Nc�����-��ۂ��i|qqI-.��݀���;G#0��v�}�����ት~<UO?^�z3d�>� �	j�	;q��#G�Z0�u~	��R��$�H�$��hb"�jS,�]��H��Vũ�<�e�v���XNB֏�r�l�S�ћ�RV-���n��!��U���-�zp�ӡX��Cz�j�N�u[��%H[o9���	�OU��>9d��;&�-t�{���p�����T�� 4{�˺1�n�=�ղhA�%@�W�X/ 	����Y"#R~�E�H�E@�Ua[	1�%�HSo���{���}�pF�?���{����h	Q����N��i�צ�������n���֖@	G���x��0e�%��MQ��T��g⻎�t8��;&�o��`�Ø9|$�~*���w"L�ާ!f�
)(��ĕJ�f�z+���X9h�߫m��teǦ��buS����F'����m@b:V#0.q5߅�y�³mA���������� -��	V@]=�F�`	2j�9h��5y-��ʶX7?j���tm�G!�9��.lW!�d`�e��'� ��,�8���#
:��N &#�!�1��]����'}�}��_%�x�.��$�;i�w�_8�&v�2�p���@X�۝L�Q[{������No��S�B	��HR$���'q�	�x��T��4�D�F ���g.9��6�gxJ�E毶i����.Iۚ�3Q�X�t8���/��G� �YC�Y��U�0��@H��n� �������)������+����]OG�H�Vv ��p��n�E~�<hUy����x:v&����O�ɴ�9د��-�S��ĭX�����'�2�NH�'H"�y.�Aʐ`������HzY��tF��m�)-Q�A42r<���^��Uꏁ`����K�=gb�!�m��D�W������&b�-Y��Q�w,=$�Ʈ@"�'`7���&7�]D_�!^-7�����J�^�H1T���؟��Ϝ�����m��kTh�o��y�{B��=����5��`�#�m�gQUν_��׳e�H�@!��5���G�<�3��\�����4��<m=y!��$�ѐ2�,�b���1���3�rsZ��AUtw���<⮫8�;yg�Gbp�9ǂ�r�mP��]Q�?��r����׺���+8�ܺb�4>��>C�)�I��z �T��5O�,��w�H1̗�c������3r��~�"����<M�S���,��鈇�W)������B�b"��߂�m��;���$l�R�x���S�����L,� ��}��<������B}���tO\6�?����B�H����u����!0X��b@���P�����E����(��M L\mOu�y��%�a$lG��~����駿e�8�dug��ޫP�	�!e����- ��o2�#��]Q��7�w��eQ�3Phݕ.ǳ���
2f�����.��Z�P{;cGOϮS�"E�����$���X�+9O{�����t��A\�JN]��rTp�]���pZ,*v�h���"�@��y��'SP��	N����ރ��, J��w����:T  ���3�hD�/}"2_�H�,���ժ2m=}q��R�@�F�>�,s�'���4à���z�A�
�;�8,����$^�p1陟:�5,W��;TH��PV��m�,)�r1&���qؾ�Amq��&:����*W�C�A m��#H��4$6���1�]�=����{�]��.'?���U����Mm� ��I��fɾ94�qY6�~�6����$��|Dّ��C,�sT��+�����p����p�ty� /���1!�\�������,[OP�	SD	
�E�"����҈'�����9`���z>�!�K�'툏%�$�㉚�ȓ�N..�"�[np��[V��"��-p�E�_�H��y��丢��ےD̬�M��RB	H �=�2È!���A��S����A�.��8��X�������%7�� b�u	 :ݍa�z:s%�S����O�`,���Q����Zs�(%�؆^p�z��@ƈ�0����~2E�ʹE��� ���.�V����|#ȓ�����?R,����-^�,�<5>�j�tp4�o���6�2��o,��$K��g�R��[	x�'��A��I?=H�G	Ҽ�k���^9c�^J8�t�нt�襞�$@4ҰaM-���w�U�4p��[��,�@ Ҩ�<�NX��$�����Ssl*%�9Ft~CϴP}@��6@6�C��#��a�8�����N�C%#!�o�;Q��&Xb,���3�X��.���I��`������DM��]̖`�p�k�E%��X"B����� #-��ޯ�����\�x��E<��Od�$�0�||r#��Wd�ý,��L� 6��WR6]թm�q��!MF)�I/��ZB��Vzb㐢��R�D�a��r���� Å0]M��eC���˺�?�(�x[��u�~ yļs��8� �Y!���B�n���k~��+X)lC�8D:\I���^:s���<�>�P&VG�N������BD�a_Z1<t���t�|��+wE�_���ʮ��|ʀ��W��𢪉��/-�'��w:M� �����gP�Q)���6����8xؖ�w�y���P-	��!W��1�n{X�'Ln�?��[ɷ-l^ ٭V
H��:�tȞ�>n�7hT1ٓd�/���y�6�>
eG �l���ž!;2���o�A4��Ǐ�3p`���P�
K-��O���%gd�ex��=D��+��=����$��C$�D�(����0��o3a�f�-��p_�6:l��p�gт#�����w��{�307f\��A����eaw��z�Lu�%y��v1�'2��,��Ζ`x/(лG��P=D��n>��Q�i��HR�K��t>�����I�5���q�x�E�s� y$�bWVx��+~��E�QmĢ�^�Qo<���.�/J��'���D���z � AH�v�+���82�@V�� �㭏Eբ�t�Q#��Z�d�7�~�䱇� R�ϢC"ȶkܥ�d�ݭ�o���H��A(�,�|r�1ܥ|���L&��<����k�kXe{���;&+��u���HR��W����8�9��"��w^�;���_BKO���UꢳIbA�0i�^,I#-|w0�i��o�!�8|���s�${>Xcl����@�(�멇Ou�����_ٵ-'�,�g�W�C 	!1o���rc����v��d�G�{�?��J@oWuS3{bb��KYYyY�2tC(�$rQg��� Bن7u�"#����Z-�[�FJ F��n���-�M�m0/��Ol��L�a����ɉH�@���C���0���m���X�=��`    ~����X�$5Pɣ��[��(��p,�&牪�f�<G��Gb�r 9�\�鱦Ԇ�Q�z6�Xf�u�MX߳<�Ӑ��!E�׷�h���$��{�|�U��F��Xj+$�ow�k���6�1]�N�����7�JC�l�Չ�}�c1u��j�%��1� ���8�%�W��]��f�Z��iܦ[���oƷI�LV;ތ�ޔ���\T��}6�*�?�7�Óg��<��F�x!�G7;K�ѥH��*7ˡ���Y�¿�rd�5�@5�$���֪Gd��AZ�;�I��Q&Vi`h����.!�L����6ey��U>��_%�X"��h@�2	�K�E����.��e�\��t�\��� ̏�,���b�/ �ЫX��w8�,��eQ~�w1hīR���^ObgI7�=������������$��K�a����NFtM!�((8�ү�׳|x=��Uϔ�t���T��!��Q�wr_�B$7�Ĳm۹UC��H�A�w?>�z��X��b�Qڝ��Al�/�=�ش�f@?բ?��k�-���TG/^����	C�Z��_/�i�a0�0���M~����^�t�SЏ�~z&���[��"�lu|]�Tǹ��P��:%�?<��� *�[݅d2���0��]E��|�}$��s|�L�(�K�q�.R�C�a�zk
��%=I:<n��h��Ha�n97C�®���7�.����~���3|.��0��8�7jc��4�J�co���dQ�S��ly������<�o�I�3&�t۞�#����{��e�F���y	Z�F��8�Cb�ڲ����/S�ޘe�6��.�gs�5:�;�Y~&������-Y�2��p��`��?\�t�]+,f���!��n�~q>�ł�OD��jhݝ��Y�k�͒��;RG��^1�_[*]Wm)�"z!}x�8�}�p���|6�^�Y��h������P`���{�y�.O��zu�~.�;켎ޏ�@̾���/�KL�������3�~ͱA�
��$TY"h)>+ ��RLv���e�`��O������Нc�r�l�����+۶�c�S�N0<ٌM��m�����������Y,,�-#��΋����Qi��C[umm]~̙��E6�v��7�~(��OMp����8^�	R��I��a��a;b�� G�M τ��`�v�`��Ls�ѵ|��r�t�t3O*a��{�c�:�ڼ�r�*�͐�{bV\����"e)ᩜ6.n8�,Cg���
�GW9��,M��﷝�1)1$e6Q�5��Y���fx��-D-�'�����F��z�:bȐ�>E'�8}�f1]8;l�#��p%��og�X�߳Ef�SR�"Ģ���W���I'���gI)kQj�D�Y��5�(�{�qrpR�._p邼$��(��|Ϡ��(��x��<��q��q�o:���]b���n�B7�`j�v�b�[u&�-��%_c�Og�FG�����I  9[!�WR/��Ly.���o�W��0�ܾaqÐi��a7ji��(���,���Jx_��\Ӑŗq��C�F�,�#ǅ7� ZL���\Lmr���G�-vVbX�,ҷt���'��1�&��Sd��پ�%�F���Nk{�r"�[w��&'S��YV����:B#����Ue�3�-���h�T�hX�����B�-5��,lC��q�''l9,�ոc���4��rvȶ%ku�A��'��b�g��1����K�$�% �^q"8/��l>ׁp]�0�P�E/	=�a��ߓјy���_����T�
��31� 0i"!TD��>r����(n+r���FҴ߸\n���D�l����0t��?����v�����8Zv��C}���~�IyqDo�����"ϚKQ-��X�4�s!�Q�rIOS�5g���~�wˤ��b�O��s���&<�t�LGXO*��U�Yv�^˪�_�.��E�c�� �/}�g8v*�)w�����T��t�v�����1�t�u-ס6b�]��\f���j�I'��ј=���F-g?>A��8���kq���ޛ���eC���6{�3#��E0=��ocg	^�
Ӳ[��}�o�������A���3����1Xb0؇�.#�a�H�L')���R5��ۺ�Qi�$���������+�h+�4>Q=�X�-�'O���Ϳ�?�^Amq8�[v��V��U��F�����kq��l��W���6�K���Q�Q5�B����Ī�=�`:�a�iFq����~$��F�6�ȑ���Bƅؾf���~�k��T&e4��m�\�Ea8�`�9լ���\{�:�d�p�2�������_��w]/j���Q�=@�Q����+�B��Z�H1�[��(��@���-6%�B�]r��iޙ'X�t�/�m�V�V�o�Z�ߗ���9W��ِb������W�fՇ�J1��.�����at��H�袍O��W]�A҂n�X69H,u��_n'����	Q���}�\$�>P��_0;͎�~Y���g�P��ɺ��S�K5�c���ܓO_�x����օ(�O��Z���"��2�Z�\ϣ��h�s����|�Aѕ�(��N�s��so��޴��Nh�QLU<B� t)���V4$#��'�wN�y�E�\3c��Ήf�	���r���w���8G6zQf��^�=�i��w1U�:u����Ƚ<W��U���cVV�L_*
=;_b�f(���9?�葽���bg~�f���з�B�s0�u��w��z�okz��>+�Nt���T�e� af<Q�qӞS/�}�"c��:�v��T���]q��'9�0�I�{�@'�#>2��
��vH���G�
f�F1D��q��MG��6���:��2�1�:u�<��T�U�&�u�6��f���@;Gf*�u��x�H��j2�U�b��/˭��Ⱥ�vO��j�t��-�Гi�����'��׎h�m�a*���9��b2�C�]��e,�kI��Z�t����\�8]�dˉ������Ch$ڢX�v��.�B0f���)(�ܒ�������cg�^b��ǓҶK�c��C���5����׷	]�ɐp��-LD��wh���?Be*m,cO1#͝��xBG2{�kR0�y�b#���E�w��c��c@�f���� �M^�<���cgQBy�\��R7��+����6��#��2��\waJiJ��}��f��~��f:_r
˸�į�Ԥ�HnE�V#�b|4^�7o�A�"k"�؋O�t����I�@���?(̀�� ��1��˞y�|�B�m>-%e>Kmb�[�&(�����:�$�E��AL�h�9!��ݾ�B����X}���
,Ҽ��)��>��c���<{))�ؕM})6�ܡI�@��A乘�E����߇β,^J24ʵߥm�<���@�`#��U�(*a����*�sذ�	:���MV�k֥s^ju�M"��GډG�z����3������d'�w�(�f��+��4I;'VQf�0��xd��A=jLH���)���� Kk�C,�-��I�B$Ƈ\�֍L0��dh�6�q��&����毜�//_����v�o�5��!�O���%�����˷��0���h)�u:��FQ��u�������I<:�w�OT�^���3�~!�^ �`�����L���9��d��B�v���Z[	��o�%@ܭ�D^��j���	=TON����>�ҹ}\��`�Ǳ�;����q��$%<�#��B������S������(���J0=�CpCoP9�$�W3�j--�� �4��F����6n��(UO����WY����eS��R�������j�!��z�)�}'����!T�@��U����~{�kw���I�A���������H��%]�,W�ۆ��} m�`�D�����C�k} I�P��_ڶ��j�%	A���7�u�*_��B��6G:ͩ^Awg �K}����Eu�Lv�4�}��*�_���k�\E�L���A��P�������.���\f_�ؙY}�@۴�XԇQ) �  ���V+�E�8}��V��Lh�l��ς��%0�}S�e�%������pϥ�.a�V����_XcW��$��br�}����m�Zb�.��a��P.w�R}��y�RRr�z�5;)_��l'�����|�(�cIL1-��K��O��?���^<E��vK��%��C���׋�λ�h~��"�|:�$�� )�	YY����\"Ƚ�㣊
+C�﷭�@۾�p���� ��ksO��!���<�o�Zn]�*R
��k�CYoX���R�{�b�zM1c�-���B͔6;��6�$�U%Av���{8J)ը��(�|Q���A���{�Ps!*�ը�=����Q�S�pֺ��&������-��	ň�x�̦^c�Ϊ��V�s����"i�Wi1��������y��9}��;d�"f�*v�3+
����s�~��A|O��%;,���kIE���b�:kGU�z�@�����0׃O�ۗ��iĶ��?�F�_��-��ow��vCuc�T��7}Oj�:�0�8��A�\�Wh+lM@��z��t�H/�T���i3
���T��m�~龼K�]gz��Vt�b��1���[�W�5�iu��<��ah	�#��ހ�[��ʭ��<��Y��w��OWmk����U��T��k�U����Kp���{,�N34a	�#��b ">9��!F���l�&�l�Je���w��`�ݿ���ƭ�V3����;���M�=he��6��Q��-Pc2O���W��n�54���P��Ѣz1l����+q�=B�V�r�Piӛ��"{T=�
f`�ZW����3)`i\�kͺ+����ʳ-d�?E�Y�eQz\G�����Շ}O���-(�=9�d�c��j��U�h�zn�X�������2�����:��h��E���g�sE�Pk���|;4���h�zL;a\�CY�Xn�ȼ����j��ݳ���{�bbd(�9���9������M�)�pH]�d YQ~%��RE�ɦ�D^-e׉���<�J\�`-���\P�+��)�*�\�b��b����4�"��U��٤N4h�����QB�z�o'-cj�AC�jY<{�4n��Ⱥ�S��B!d�!>Ċ��r�-���;�\��B*�����?S�M�������"f8!I��%]ߪDh�r2�R��Ҕj]��,��W�h��G��ۅ{Z�&C&�<B�j�1'���7�.B��@N!�r�:��"1A���Z��d}���40*;v��oD}�Ё���q�Q`��E�ծf�}��\���Q@oBx�����ٝ�賒il�9�r%櫢�s�|�
�vW��冠{���?3Ql��F��D~j�l��»��F���0+.�{|���ܳ�ƴ��[f/D�]ro��Bi#��?��'�f�������/��cF��E�.P?/�R`���A���E0���0�R8=��_w�scZ��Ģ��LS[/J �k>&����Z��� 3xJ�F1T�x�$�J�Cs�.�d絜�Ȳ(�UUHd�����(K���1����{��*�AGT���+Zʚ�!o+�çJ��{ٹ�ty�}�eh�$dz!�Q�SʗG��~J>�ru���M��W�Խ�Ա��) �FN5$u�<�������0"߮<�%�)�@���FEex��r��˺��/���жoiaˁ�/+)�37I%8���P��JS����uv��h'�JB��sc��OJ �-d�e�Pu���/`t��jK�x8�K��Te���|33-:쾋�i��}hn�&�1�>�S�(�x�tgEg�Y��vj�9�U@W��aۡ�<����Wr �>�!KE	zN���%��lws:ZʙB$_�0P��'�Nܛ^�"�(�Vby�	W?�ٵ�:Z��l���I����>�)�d�5qQ�"��ڻsӕ���m~�����?*     