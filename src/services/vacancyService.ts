

import { PrismaClient } from "@prisma/client";
import { z } from 'zod'

interface VacancyData {
    id?: number;
    title: string;
    schooling: string;
    language: string[];
    language_level: string[];
    accept_pcd: boolean;
    country: string;
    state: string;
    city: string;
    neighborhood: string;
    alocation: string;
    travel: boolean;
    duration: number;
    hiring_type: string;
    quantity: number;
    job_owner: string;
    priority: string;
    status: string;
    description: string;
    tags: string;
    internal_notes: string;
    salary: number;
}



class VacancyService {
    private prisma: PrismaClient
    private vacancySchema: z.Schema<VacancyData>

    constructor() {
        this.prisma = new PrismaClient()
        this.vacancySchema = z.object({
            id: z.optional(z.number()),
            title: z.string(),
            schooling: z.string(),
            language: z.array(z.string()),
            language_level: z.array(z.string()),
            accept_pcd: z.boolean(),
            country: z.string(),
            state: z.string(),
            city: z.string(),
            neighborhood: z.string(),
            alocation: z.string(),
            travel: z.boolean(),
            duration: z.number(),
            hiring_type: z.string(),
            quantity: z.number(),
            job_owner: z.string(),
            priority: z.string(),
            status: z.string(),
            description: z.string(),
            tags: z.string(),
            internal_notes: z.string(),
            salary: z.number(),
        })
    }

    public createVacancy = async (data: VacancyData) => {
        try {
            this.vacancySchema.parse(data)
            const newVacancy = await this.prisma.vaga.create({ data })

            return newVacancy
        } catch (error) {
            console.log("error", error)
            throw new Error('Ocorreu um erro ao criar a vaga.');
        }
    }

    public updateVacancy = async (data: VacancyData) => {


        this.vacancySchema.parse(data)

        const updateVacancy = await this.prisma.vaga.update({
            where: {
                id: data.id
            },

            data
        })

        return updateVacancy
    }
}

export default VacancyService