import express, {Router} from 'express'
import { CandidateController } from '../controllers/jobController'
import { VacancyController } from '../controllers/vacancyController'

const router = express.Router()
const candidateController = new CandidateController()
const vacancyController = new VacancyController()

router.get("/candidates", candidateController.getAllCandidates)
router.get('/vacancies', vacancyController.getAllVacancies)
router.post('/vacancies', vacancyController.createVacancyController)
router.put('/vacancies/:id', vacancyController.updateVacancyController)

export default router