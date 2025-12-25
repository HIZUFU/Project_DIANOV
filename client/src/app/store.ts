import { configureStore } from '@reduxjs/toolkit';

export const store = configureStore({
  reducer: {
    // твои редюсеры будут здесь
  },
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;