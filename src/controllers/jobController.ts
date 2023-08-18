import { PrismaClient, Candidato } from "@prisma/client";
import {Request,Response} from 'express'
import { CustomError } from "../utils/customError";
const prisma = new PrismaClient()

export class CandidateController {
    public async getAllCandidates(req: Request, res:Response) {
        try {
            const name = req.params.name

            const candidates = await prisma.candidato.findMany({
                where: {
                    name: {startsWith: name}
                }
            })

            if(!candidates) {
                throw new CustomError("Candidato não encontrado", 404)
            }

            return res.status(200).json(candidates)
        } catch (error) {
            return res.status(500).json({error: "Ocorreu um erro ao procurar os candidatos."})
        }
    }
}