-- DropForeignKey
ALTER TABLE "Vaga" DROP CONSTRAINT "Vaga_company_id_fkey";

-- AlterTable
ALTER TABLE "Vaga" ALTER COLUMN "company_id" DROP NOT NULL;

-- AddForeignKey
ALTER TABLE "Vaga" ADD CONSTRAINT "Vaga_company_id_fkey" FOREIGN KEY ("company_id") REFERENCES "Empresa"("id") ON DELETE SET NULL ON UPDATE CASCADE;
