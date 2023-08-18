import { NextFunction } from "express";
import {Request, Response} from 'express'
import { CustomError } from "../utils/customError";

export function errorHandler(err: any, req: Request, res:Response, next: NextFunction) {
    if(err instanceof CustomError) {
        return res.status(err.statusCode).json({error: err.message})
    } else {
        console.error("Erro não esperado", err)

        return res.status(500).json({error: "Ocorreu um erro no servidor"})
    }
}