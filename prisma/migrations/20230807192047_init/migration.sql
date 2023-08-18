/*
  Warnings:

  - You are about to drop the `Post` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Profile` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Post" DROP CONSTRAINT "Post_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Profile" DROP CONSTRAINT "Profile_userId_fkey";

-- DropTable
DROP TABLE "Post";

-- DropTable
DROP TABLE "Profile";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "Candidato" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "middle_name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "cell_phone" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "gender" TEXT NOT NULL,
    "pcd" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "country" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "seniority" TEXT NOT NULL,
    "neighborhood" TEXT NOT NULL,
    "review" TEXT NOT NULL,
    "blacklist" BOOLEAN NOT NULL DEFAULT false,
    "review_blacklist" TEXT NOT NULL,
    "latest_company" TEXT NOT NULL,
    "salary_expectation" INTEGER NOT NULL,
    "salary_actual" INTEGER,
    "disponibility_begin" TIMESTAMP(3) NOT NULL,
    "travel" BOOLEAN NOT NULL,
    "change_availability" BOOLEAN NOT NULL,
    "alocation" TEXT NOT NULL,
    "schooling" TEXT NOT NULL,
    "skills" TEXT[],
    "languages" TEXT[],
    "language_level" TEXT[],
    "social_media" TEXT NOT NULL,
    "weblinks" TEXT NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "Candidato_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vaga" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "schooling" TEXT NOT NULL,
    "language" TEXT[],
    "language_level" TEXT[],
    "accept_pcd" BOOLEAN NOT NULL,
    "country" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "city" TEXT NOT NULL,
    "neighborhood" TEXT NOT NULL,
    "alocation" TEXT NOT NULL,
    "travel" BOOLEAN NOT NULL,
    "duration" INTEGER NOT NULL,
    "hiring_type" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL,
    "job_owner" TEXT NOT NULL,
    "company_id" INTEGER NOT NULL,
    "priority" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "tags" TEXT NOT NULL,
    "internal_notes" TEXT NOT NULL,
    "salary" INTEGER NOT NULL,

    CONSTRAINT "Vaga_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Candidato_Vaga" (
    "candidato_id" INTEGER NOT NULL,
    "vaga_id" INTEGER NOT NULL,

    CONSTRAINT "Candidato_Vaga_pkey" PRIMARY KEY ("candidato_id","vaga_id")
);

-- CreateTable
CREATE TABLE "Habilidade" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "Habilidade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Vaga_Habilidade" (
    "id" SERIAL NOT NULL,
    "vaga_id" INTEGER NOT NULL,
    "habilidade_id" INTEGER NOT NULL,

    CONSTRAINT "Vaga_Habilidade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Empresa" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "addres" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "website" TEXT,
    "industry" TEXT NOT NULL,
    "size" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "Empresa_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Entrevista" (
    "id" SERIAL NOT NULL,
    "candidate_id" INTEGER,
    "entrevistador_id" INTEGER NOT NULL,

    CONSTRAINT "Entrevista_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Candidato_email_key" ON "Candidato"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Habilidade_name_key" ON "Habilidade"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Vaga_Habilidade_vaga_id_habilidade_id_key" ON "Vaga_Habilidade"("vaga_id", "habilidade_id");

-- CreateIndex
CREATE UNIQUE INDEX "Empresa_email_key" ON "Empresa"("email");

-- AddForeignKey
ALTER TABLE "Vaga" ADD CONSTRAINT "Vaga_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Empresa"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Candidato_Vaga" ADD CONSTRAINT "Candidato_Vaga_vaga_id_fkey" FOREIGN KEY ("vaga_id") REFERENCES "Vaga"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Candidato_Vaga" ADD CONSTRAINT "Candidato_Vaga_candidato_id_fkey" FOREIGN KEY ("candidato_id") REFERENCES "Candidato"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vaga_Habilidade" ADD CONSTRAINT "Vaga_Habilidade_vaga_id_fkey" FOREIGN KEY ("vaga_id") REFERENCES "Vaga"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Vaga_Habilidade" ADD CONSTRAINT "Vaga_Habilidade_habilidade_id_fkey" FOREIGN KEY ("habilidade_id") REFERENCES "Habilidade"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Entrevista" ADD CONSTRAINT "Entrevista_candidate_id_fkey" FOREIGN KEY ("candidate_id") REFERENCES "Candidato"("id") ON DELETE SET NULL ON UPDATE CASCADE;
