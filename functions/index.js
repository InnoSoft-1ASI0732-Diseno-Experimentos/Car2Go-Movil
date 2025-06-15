import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { initializeApp } from "firebase-admin/app";
import { getMessaging } from "firebase-admin/messaging";

initializeApp();

export const notificarError = onDocumentCreated("errores/{id}", async (event) => {
  const error = event.data?.data();

  const payload = {
    notification: {
      title: `🚨 Error detectado`,
      body: `${error.titulo}: ${error.descripcion}`,
    },
    topic: 'alertas-dev',
  };

  await getMessaging().send(payload);
  console.log('Notificación enviada');
});
