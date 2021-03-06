
CREATE SEQUENCE public.user_roles_id_seq;

CREATE TABLE public.utilisateur_roles (
                userRoleId INTEGER NOT NULL DEFAULT nextval('public.user_roles_id_seq'),
                rolename VARCHAR(45) NOT NULL,
                CONSTRAINT utilisateur_roles_pk PRIMARY KEY (userRoleId)
);


ALTER SEQUENCE public.user_roles_id_seq OWNED BY public.utilisateur_roles.userRoleId;

CREATE TABLE public.App_User (
                username VARCHAR(36) NOT NULL,
                adresse_mail VARCHAR(120) NOT NULL,
                password VARCHAR(128) NOT NULL,
                nom VARCHAR(30) NOT NULL,
                prenom VARCHAR(30) NOT NULL,
                CONSTRAINT app_user_pk PRIMARY KEY (username)
);


CREATE SEQUENCE public.app_user_roles_idref_seq;

CREATE TABLE public.app_user_roles (
                idRef BIGINT NOT NULL DEFAULT nextval('public.app_user_roles_idref_seq'),
                roles_userroleid INTEGER NOT NULL,
                app_user_username VARCHAR(36) NOT NULL,
                CONSTRAINT app_user_roles_pk PRIMARY KEY (idRef)
);


ALTER SEQUENCE public.app_user_roles_idref_seq OWNED BY public.app_user_roles.idRef;

CREATE TABLE public.Bar (
                nom VARCHAR(90) NOT NULL,
                adresse VARCHAR(255) NOT NULL,
                postal VARCHAR NOT NULL,
                ville VARCHAR(255) NOT NULL,
                description VARCHAR(255) NOT NULL,
                CONSTRAINT bar_pk PRIMARY KEY (nom)
);


CREATE SEQUENCE public.commentaire_idcom_seq;

CREATE TABLE public.Commentaire (
                idCom BIGINT NOT NULL DEFAULT nextval('public.commentaire_idcom_seq'),
                username VARCHAR(36) NOT NULL,
                titre VARCHAR(50) NOT NULL,
                nombar VARCHAR(90) NOT NULL,
                description VARCHAR(255) NOT NULL,
                CONSTRAINT commentaire_pk PRIMARY KEY (idCom)
);


ALTER SEQUENCE public.commentaire_idcom_seq OWNED BY public.Commentaire.idCom;

CREATE SEQUENCE public.biere_idbiere_seq;

CREATE TABLE public.Biere (
                idBiere BIGINT NOT NULL DEFAULT nextval('public.biere_idbiere_seq'),
                nombiere VARCHAR(90) NOT NULL,
                nombar VARCHAR(90) NOT NULL,
                variete VARCHAR(255) NOT NULL,
                region VARCHAR(255) NOT NULL,
                degres REAL NOT NULL,
                CONSTRAINT biere_pk PRIMARY KEY (idBiere)
);


ALTER SEQUENCE public.biere_idbiere_seq OWNED BY public.Biere.idBiere;

ALTER TABLE public.app_user_roles ADD CONSTRAINT utilisateur_roles_app_user_roles_fk
FOREIGN KEY (roles_userroleid)
REFERENCES public.utilisateur_roles (userRoleId)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commentaire ADD CONSTRAINT app_user_commentaire_fk
FOREIGN KEY (username)
REFERENCES public.App_User (username)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.app_user_roles ADD CONSTRAINT app_user_app_user_roles_fk
FOREIGN KEY (app_user_username)
REFERENCES public.App_User (username)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Biere ADD CONSTRAINT bar_biere_fk
FOREIGN KEY (nombar)
REFERENCES public.Bar (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Commentaire ADD CONSTRAINT bar_commentaire_fk
FOREIGN KEY (nombar)
REFERENCES public.Bar (nom)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
