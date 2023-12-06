# Decisão da arquitetura utilizada

A arquitetura selecionada para o projeto adota uma estrutura de Model-View-Presenter (MVP).

#### View
Na camada de _View_, a responsabilidade principal é exibir a interface ao usuário e gerar eventos conforme as entradas recebidas.

Esta camada não deve ter conhecimento de qualquer interface de _use case_, _repository_ ou _data source_. Toda comunicação deve ocorrer exclusivamente pela interação com o _presenter_.

É responsabilidade dessa camada atualizar o estado da aplicação de acordo com as informações enviadas pelo presenter.

#### Presenter

O _Presenter_ atua como intermediário, ouvindo eventos da _View_ e invocando a camada de _Model_ para obter informações externas à aplicação.

Com base na resposta recebida, o _Presenter_ envia um novo estado para a camada de _View_. Além disso, é responsabilidade do _Presenter_ lidar com a navegação para outras telas.

Esta camada deve conhecer apenas _use cases_ e _screen directions_(classe responsável por conter métodos de navegação pertinentes ao módulo atual).

Não deve realizar tratamento de exceções. O _use case_ deve devolver um valor que possa ser interpretado como erro, e o presenter apenas deve orquestrar o estado de erro.

#### Model
A camada de Model assume a responsabilidade de comunicar-se com recursos externos ao aplicativo.

Esta camada abrange entidades, _use cases_, _repositories_ e _data soruces._

Os _use cases_ são responsáveis por orquestrar os recursos necessários para a execução da regra de negócio.

Os _repositories_ são encarregados de chamar os _data sources_, tratar seus valores para uma entidade conhecida pelo projeto e realizar o tratamento de exceções.

Os _data sources_ são responsáveis por efetuar requisições a servidores externos e retornar os valores brutos.

# Lista de bibliotecas de terceiros utilizadas

#### Injeção de dependências
- get_it
- injectable
- injectable_generator

#### Requisições http
- http

#### Persistência de dados
- shared_preferences

#### Gerenciamento de estado
- bloc
- flutter_bloc

#### Testes
- bloc_test
- mocktail

#### Outros
- build_runner (Usado na geração de código)
- intl (Usado na conversão de objetos DateTime para o formato yyyy-MM-dd e dd-MM-yyyy)
- equatable (Usado para auxiliar na sobrecarga de operadores de igualdade)


# O que você melhoraria se tivesse mais tempo

1. Atualmente, o token e senha do usuário são armazenados em cache após o login. Recomenda-se implementar uma camada de cache seguro (utilizando a solução [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage), por exemplo)

2. O token atualmente não é utilizado em momento algum. Sugiro a criação de um decorator sobre o cliente http para interceptar as requisições, recuperar o token da memória e adicioná-lo aos headers. Essa abordagem simula um cenário real onde é necessário fornecer informações de autenticação a cada requisição, sem a necessidade de inclur o token manualmente em todas as requisições.

3. A experiência do usuário nos formulários atualmente não é amigável. Seria interessante implementar um sistema de foco nas telas de login, criação e edição de estudantes, de forma a selecionar automaticamente os campos e avançar para o próximo campo editável conforme o progresso no formulário.

4. Na tela de listagem de estudantes, há uma animação para a inserção e remoção de estudantes. Sugiro realizar experimentos em uma build de release usando o dartDevTools para medir o desempenho, incluindo os rebuilds realizados. Com base nesse diagnóstico, tomar decisões sobre possíveis otimizações.

5. Na tela de listagem de estudantes, em um estado onde não há nenhum estudante cadastrado, é exibida uma lista vazia. Seria interessante fornecer um feedback para esse estado vazio, instruindo o usuário a criar um novo estudante.

6. Existe um mixin chamado ValidatorMixin, responsável por agrupar métodos de validação. Recomenda-se criar testes unitários para validar as respostas de erro desses métodos.

7. Na tela de listagem de estudantes, ficou pendente a implementação do sistema de busca dos estudantes.

# Quais requisitos obrigatórios que não foram entregues

1. Ao criar um novo registro de estudante, o campo data de nascimento não é considerado obrigatório. Atualmente, o preenchimento desse campo é essencial.

2. Na tela de splash do Android, o ícone exibido não corresponde ao esperado, e no iOS, a imagem de introdução parece estar ligeiramente desproporcional.

