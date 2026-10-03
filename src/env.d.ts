// Types for the variables defined in .env, so import.meta.env is type-checked.
interface ImportMetaEnv {
  readonly VITE_APP_TITLE: string
  readonly VITE_WEIGHT_UNIT: 'kg' | 'lb'
}

interface ImportMeta {
  readonly env: ImportMetaEnv
}
