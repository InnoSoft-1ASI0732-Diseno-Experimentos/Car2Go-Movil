import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { logger } from "firebase-functions";
import { initializeApp } from "firebase-admin/app";
import { getMessaging } from "firebase-admin/messaging";

initializeApp();

export const notificarError = onDocumentCreated("errores/{id}", async (event) => {
  const error = event.data?.data();

  if (!error || !error.titulo || !error.descripcion) {
    logger.warn("Documento de error incompleto o nulo", { error });
    return;
  }

  const payload = {
    notification: {
      title: `🚨 Error detectado`,
      body: `${error.titulo}: ${error.descripcion}`,
    },
    topic: 'alertas-dev',
  };

  try {
    const response = await getMessaging().send(payload);
    logger.info("Notificación enviada con éxito", { response });
  } catch (err) {
    logger.error("Error al enviar la notificación", { err });
  }
});
