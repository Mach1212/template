import pino from "pino";
import { LOG_LEVEL } from "./env.ts";

const transport = pino.transport({
  targets: [
    {
      level: LOG_LEVEL,
      target: "pino-pretty",
      options: {},
    },
    {
      level: "trace",
      target: "pino/file",
      options: { destination: `./log/${Date.now()}.log` },
    },
  ],
});

export const logger = pino(transport);
