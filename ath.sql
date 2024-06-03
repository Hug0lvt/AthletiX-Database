CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL,
    CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId")
);

START TRANSACTION;

CREATE TABLE "AspNetRoles" (
    "Id" text NOT NULL,
    "Name" character varying(256),
    "NormalizedName" character varying(256),
    "ConcurrencyStamp" text,
    CONSTRAINT "PK_AspNetRoles" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetUsers" (
    "Id" text NOT NULL,
    "UserName" character varying(256),
    "NormalizedUserName" character varying(256),
    "Email" character varying(256),
    "NormalizedEmail" character varying(256),
    "EmailConfirmed" boolean NOT NULL,
    "PasswordHash" text,
    "SecurityStamp" text,
    "ConcurrencyStamp" text,
    "PhoneNumber" text,
    "PhoneNumberConfirmed" boolean NOT NULL,
    "TwoFactorEnabled" boolean NOT NULL,
    "LockoutEnd" timestamp with time zone,
    "LockoutEnabled" boolean NOT NULL,
    "AccessFailedCount" integer NOT NULL,
    CONSTRAINT "PK_AspNetUsers" PRIMARY KEY ("Id")
);

CREATE TABLE "Categories" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Title" character varying(30) NOT NULL,
    CONSTRAINT "PK_Categories" PRIMARY KEY ("Id")
);

CREATE TABLE "Conversations" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Name" text NOT NULL,
    "Picture" text NOT NULL,
    CONSTRAINT "PK_Conversations" PRIMARY KEY ("Id")
);

CREATE TABLE "Profiles" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Username" character varying(50) NOT NULL,
    "UniqueNotificationToken" text NOT NULL,
    "Role" integer NOT NULL,
    "Age" integer NOT NULL,
    "Email" character varying(30) NOT NULL,
    "Weight" real NOT NULL,
    "Height" real NOT NULL,
    "Gender" boolean NOT NULL,
    "Picture" text NOT NULL,
    CONSTRAINT "PK_Profiles" PRIMARY KEY ("Id")
);

CREATE TABLE "AspNetRoleClaims" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "RoleId" text NOT NULL,
    "ClaimType" text,
    "ClaimValue" text,
    CONSTRAINT "PK_AspNetRoleClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetRoleClaims_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserClaims" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "UserId" text NOT NULL,
    "ClaimType" text,
    "ClaimValue" text,
    CONSTRAINT "PK_AspNetUserClaims" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_AspNetUserClaims_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserLogins" (
    "LoginProvider" text NOT NULL,
    "ProviderKey" text NOT NULL,
    "ProviderDisplayName" text,
    "UserId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserLogins" PRIMARY KEY ("LoginProvider", "ProviderKey"),
    CONSTRAINT "FK_AspNetUserLogins_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserRoles" (
    "UserId" text NOT NULL,
    "RoleId" text NOT NULL,
    CONSTRAINT "PK_AspNetUserRoles" PRIMARY KEY ("UserId", "RoleId"),
    CONSTRAINT "FK_AspNetUserRoles_AspNetRoles_RoleId" FOREIGN KEY ("RoleId") REFERENCES "AspNetRoles" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_AspNetUserRoles_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "AspNetUserTokens" (
    "UserId" text NOT NULL,
    "LoginProvider" text NOT NULL,
    "Name" text NOT NULL,
    "Value" text,
    CONSTRAINT "PK_AspNetUserTokens" PRIMARY KEY ("UserId", "LoginProvider", "Name"),
    CONSTRAINT "FK_AspNetUserTokens_AspNetUsers_UserId" FOREIGN KEY ("UserId") REFERENCES "AspNetUsers" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Exercises" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "CategoryId" integer NOT NULL,
    "Name" text NOT NULL,
    "Description" text NOT NULL,
    "Image" text NOT NULL,
    CONSTRAINT "PK_Exercises" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Exercises_Categories_CategoryId" FOREIGN KEY ("CategoryId") REFERENCES "Categories" ("Id") ON DELETE CASCADE
);

CREATE TABLE "ConversationMembers" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "ConversationId" integer NOT NULL,
    "ProfileId" integer NOT NULL,
    CONSTRAINT "PK_ConversationMembers" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ConversationMembers_Conversations_ConversationId" FOREIGN KEY ("ConversationId") REFERENCES "Conversations" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_ConversationMembers_Profiles_ProfileId" FOREIGN KEY ("ProfileId") REFERENCES "Profiles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Messages" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "ConversationId" integer NOT NULL,
    "ProfileId" integer NOT NULL,
    "Content" character varying(3000) NOT NULL,
    "DateSent" timestamp with time zone NOT NULL,
    CONSTRAINT "PK_Messages" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Messages_Conversations_ConversationId" FOREIGN KEY ("ConversationId") REFERENCES "Conversations" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Messages_Profiles_ProfileId" FOREIGN KEY ("ProfileId") REFERENCES "Profiles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Posts" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "ProfileId" integer NOT NULL,
    "CategoryId" integer NOT NULL,
    "Title" text NOT NULL,
    "Description" text NOT NULL,
    "PublicationType" integer NOT NULL,
    "Content" text NOT NULL,
    CONSTRAINT "PK_Posts" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Posts_Categories_CategoryId" FOREIGN KEY ("CategoryId") REFERENCES "Categories" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Posts_Profiles_ProfileId" FOREIGN KEY ("ProfileId") REFERENCES "Profiles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Sessions" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "ProfileId" integer NOT NULL,
    "Name" text NOT NULL,
    "Date" timestamp with time zone NOT NULL,
    "Duration" interval NOT NULL,
    CONSTRAINT "PK_Sessions" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Sessions_Profiles_ProfileId" FOREIGN KEY ("ProfileId") REFERENCES "Profiles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Comments" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "PublishDate" timestamp with time zone NOT NULL,
    "ProfileId" integer NOT NULL,
    "PostId" integer NOT NULL,
    "Content" character varying(1000) NOT NULL,
    "ParentCommentId" integer,
    CONSTRAINT "PK_Comments" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Comments_Comments_ParentCommentId" FOREIGN KEY ("ParentCommentId") REFERENCES "Comments" ("Id"),
    CONSTRAINT "FK_Comments_Posts_PostId" FOREIGN KEY ("PostId") REFERENCES "Posts" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Comments_Profiles_ProfileId" FOREIGN KEY ("ProfileId") REFERENCES "Profiles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "LikedPosts" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "LikedByThisProfileId" integer NOT NULL,
    "LikedPostId" integer NOT NULL,
    CONSTRAINT "PK_LikedPosts" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_LikedPosts_Posts_LikedPostId" FOREIGN KEY ("LikedPostId") REFERENCES "Posts" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_LikedPosts_Profiles_LikedByThisProfileId" FOREIGN KEY ("LikedByThisProfileId") REFERENCES "Profiles" ("Id") ON DELETE CASCADE
);

CREATE TABLE "PracticalExercises" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "ExerciseId" integer NOT NULL,
    "SessionId" integer NOT NULL,
    CONSTRAINT "PK_PracticalExercises" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_PracticalExercises_Exercises_ExerciseId" FOREIGN KEY ("ExerciseId") REFERENCES "Exercises" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_PracticalExercises_Sessions_SessionId" FOREIGN KEY ("SessionId") REFERENCES "Sessions" ("Id") ON DELETE CASCADE
);

CREATE TABLE "Sets" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "ExerciseId" integer NOT NULL,
    "Reps" integer NOT NULL,
    "WeightJson" text NOT NULL,
    "Rest" interval NOT NULL,
    "Mode" integer NOT NULL,
    "IsDone" boolean NOT NULL,
    CONSTRAINT "PK_Sets" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Sets_PracticalExercises_ExerciseId" FOREIGN KEY ("ExerciseId") REFERENCES "PracticalExercises" ("Id") ON DELETE CASCADE
);

CREATE INDEX "IX_AspNetRoleClaims_RoleId" ON "AspNetRoleClaims" ("RoleId");

CREATE UNIQUE INDEX "RoleNameIndex" ON "AspNetRoles" ("NormalizedName");

CREATE INDEX "IX_AspNetUserClaims_UserId" ON "AspNetUserClaims" ("UserId");

CREATE INDEX "IX_AspNetUserLogins_UserId" ON "AspNetUserLogins" ("UserId");

CREATE INDEX "IX_AspNetUserRoles_RoleId" ON "AspNetUserRoles" ("RoleId");

CREATE INDEX "EmailIndex" ON "AspNetUsers" ("NormalizedEmail");

CREATE UNIQUE INDEX "UserNameIndex" ON "AspNetUsers" ("NormalizedUserName");

CREATE UNIQUE INDEX "IX_Categories_Title" ON "Categories" ("Title");

CREATE INDEX "IX_Comments_ParentCommentId" ON "Comments" ("ParentCommentId");

CREATE INDEX "IX_Comments_PostId" ON "Comments" ("PostId");

CREATE INDEX "IX_Comments_ProfileId" ON "Comments" ("ProfileId");

CREATE UNIQUE INDEX "IX_ConversationMembers_ConversationId_ProfileId" ON "ConversationMembers" ("ConversationId", "ProfileId");

CREATE INDEX "IX_ConversationMembers_ProfileId" ON "ConversationMembers" ("ProfileId");

CREATE INDEX "IX_Exercises_CategoryId" ON "Exercises" ("CategoryId");

CREATE UNIQUE INDEX "IX_LikedPosts_LikedByThisProfileId_LikedPostId" ON "LikedPosts" ("LikedByThisProfileId", "LikedPostId");

CREATE INDEX "IX_LikedPosts_LikedPostId" ON "LikedPosts" ("LikedPostId");

CREATE INDEX "IX_Messages_ConversationId" ON "Messages" ("ConversationId");

CREATE INDEX "IX_Messages_ProfileId" ON "Messages" ("ProfileId");

CREATE INDEX "IX_Posts_CategoryId" ON "Posts" ("CategoryId");

CREATE INDEX "IX_Posts_ProfileId" ON "Posts" ("ProfileId");

CREATE INDEX "IX_PracticalExercises_ExerciseId" ON "PracticalExercises" ("ExerciseId");

CREATE INDEX "IX_PracticalExercises_SessionId" ON "PracticalExercises" ("SessionId");

CREATE UNIQUE INDEX "IX_Profiles_Email" ON "Profiles" ("Email");

CREATE INDEX "IX_Sessions_ProfileId" ON "Sessions" ("ProfileId");

CREATE INDEX "IX_Sets_ExerciseId" ON "Sets" ("ExerciseId");

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20240603093244_Ath-v2', '8.0.5');

COMMIT;