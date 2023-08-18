import express from 'express'
import { errorHandler } from './middlewares/errorHandler'
import routes from './routes'


const app = express()
app.use(errorHandler)
app.use(express.json())


app.use("/", routes)

const PORT = 3000;



app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});