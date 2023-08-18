import { PrismaClient, Candidato } from "@prisma/client";
import { Request, Response } from 'express'
import { CustomError } from "../utils/customError";
import VacancyService from "../services/vacancyService";
const prisma = new PrismaClient()

const vacancyService = new VacancyService()

export class VacancyController {
    public async getAllVacancies(req: Request, res: Response) {
        try {
            const name = req.params.name

            const vacancies = await prisma.vaga.findMany({
                where: {
                    title: { startsWith: name },
                },
                include: {
                    company: true, // Inclua os detalhes da empresa relacionada
                    habilities: true, // Inclua as habilidades relacionadas
                },
            });


            if (vacancies.length === 0) {
                return res.status(204).send(); // Retorna um status 204 (No Content)
            }

            return res.status(200).json(vacancies)
        } catch (error) {
            console.log("error", error)
            return res.status(500).json({ error: "Ocorreu um erro ao procurar os candidatos." })
        }
    }

    public async createVacancyController(req: Request, res: Response) {
        try {
            const vacancyData = req.body;

            console.error("Zod validation error:", vacancyData);
            const newVacancy = await vacancyService.createVacancy(vacancyData);
      
            return res.status(201).json(newVacancy);
        } catch (error) {
            return res.status(500).json({ error: 'Ocorreu um erro ao criar a vaga.' })
        }
    }

    public async updateVacancyController(req: Request, res: Response) {
        try {
            const {id} = req.params
            const vacancyData = req.body


            vacancyData.id = Number(id)

            const updatedVacancy = await vacancyService.updateVacancy(vacancyData)

            return res.status(200).json(updatedVacancy)

        } catch (error) {
            console.log("error", error)
            return res.status(500).json({ error: 'Ocorreu um erro ao atualizar a vaga.' })
        }
    }
}