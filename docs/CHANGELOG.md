# [2.0.1] - 2017-06-20

## Feature:
- Adicionado suporta para o launchDarkly
- Adicionado suporte para login com keycloack
- Adição dos seguintes formatadores de texto:
   - `DateInputFormatter`: '12/12/2022'
   - `CNPJInputFormatter`: '11.111.111/1111-11'
   - `CPFAndCNPJInputFormatter`: 
       - quando menor que 12 digitos: '111.111.111-11'
       - quando maior ou igual a 12 digitos: '11.111.111/1111-11'

# [1.0.0] - 2017-06-20

### Feature:
- Adição do logger para os logs de requests e erros
- Adição do firebase crashlytics, performance, firestore
- Adição dos seguintes formatadores de texto:
   - CPFInputFormatter (formatador de CPF)
   - CurrencyInputFormatter (formatador de Valores sem centavos)
   - KwhInputFormatter (formatador de geração de energia)
   - PhoneInputFormatter (formatador de telefone)
- Adição do adapter para SharedPreferences 
- Adição dos extensions para:
   -  DateFormat
   - Iterable
   - Number
   - ScrollController
   - String

[1.1.0]: https://github.com/solfacil/sdk-tools-mobile/releases/tag/1.1.0
[1.0.0]: https://github.com/solfacil/sdk-tools-mobile/releases/tag/1.0.0