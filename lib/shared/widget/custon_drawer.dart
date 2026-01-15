import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/binance/variacao_pre%C3%A7o_page.dart';
import 'package:trilhaapp/pages/login_page.dart';
import 'package:trilhaapp/pages/dados_cadastrais/dados_cadastrais_hive.dart';
import 'package:trilhaapp/pages/configuracoes/configuracoes_hive_page.dart';
import 'package:trilhaapp/pages/numeros_aleatorio/numeros_aleatorios_hive_page.dart';
import 'package:trilhaapp/pages/post_page.dart';
import 'package:trilhaapp/repositories/back4app/tarefas_back4app_repository.dart';
import 'package:trilhaapp/repositories/binance/endpoint_publico/binance_repository.dart';

class CustonDrawer extends StatelessWidget {
  const CustonDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                context: context,
                builder: (BuildContext bc) {
                  return Wrap(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Text("Camera"),
                        leading: Icon(Icons.camera_alt),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        title: Text("Galeria"),
                        leading: Icon(Icons.photo),
                      ),
                    ],
                  );
                },
              );
            },
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.orange),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                  "http://hermes.digitalinnovation.one/assets/diome/logo.png",
                ),
              ),
              accountName: Text("Lucas Adriano"),
              accountEmail: Text("email@email.com"),
            ),
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.person),
                  SizedBox(width: 5),
                  Text("Dados Cadastrais"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DadosCadastraisHivePage(),
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.info),
                  SizedBox(width: 5),
                  Text("Termos de uso e privacidade"),
                ],
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10),
                ),
                context: context,
                builder: (BuildContext bc) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Column(
                      children: [
                        Text(
                          "Termos de uso e privacidade",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          "Ao aceitar este Termo de Consentimento, o usuário autoriza a utilização de seus dados pelo sistema, exclusivamente para as finalidades operacionais necessárias ao funcionamento da plataforma, incluindo cadastro, autenticação, comunicação, processamento de informações e melhoria dos serviços.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.settings),
                  SizedBox(width: 5),
                  Text("Configurações"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (bc) => const ConfiguracoesHivePage(),
                ),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.numbers),
                  SizedBox(width: 5),
                  Text("Gerador de números"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (bc) => const NumerosAleatoriosHivePage(),
                ),
              );
            },
          ),
          Divider(),
          SizedBox(height: 10),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.post_add),
                  SizedBox(width: 5),
                  Text("Posts"),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (bc) => const PostsPage()),
              );
            },
          ),
          Divider(),
          SizedBox(height: 10),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.monetization_on_outlined),
                  SizedBox(width: 5),
                  Text("Binance"),
                ],
              ),
            ),
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (bc) => const VariacaPrecoPage()),
              );
            },
          ),
          Divider(),
          SizedBox(height: 10),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.http),
                  SizedBox(width: 5),
                  Text("Tarefas HTTP"),
                ],
              ),
            ),
            onTap: () async {
              var tarefa = TarefasBack4appRepository();
              var tarefas = await tarefa.obterTarefas();
              print(tarefas);
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (bc) => const VariacaPrecoPage()),
              // );
            },
          ),
          Divider(),
          SizedBox(height: 10),
          InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              width: double.infinity,
              child: Row(
                children: [
                  const Icon(Icons.exit_to_app),
                  SizedBox(width: 5),
                  Text("Sair"),
                ],
              ),
            ),

            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    alignment: Alignment.centerLeft,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(10),
                    ),
                    title: Text(
                      "Meu App",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: Wrap(
                      children: [
                        Text("Voce sairá do aplicativo!"),
                        Text("Deseja realmente sair do aplicativo?"),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Não"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text("Sim"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
/*
Perfeito. Vou tratar **os 4 pontos de forma integrada**, com **datas, critérios objetivos e sem romantizar**.
Pense nisso como um **plano de transição profissional de 3 anos**, feito para alguém **adulto, com contas e carreira prévia**.

---

# 1️⃣ PLANO DE TRANSIÇÃO SALARIAL (REALISTA)

## 📍 Situação atual

* Supervisor faturamento: **R$ 4.000 bruto**
* Estágio Flutter: **R$ 1.200**
* Total: **~R$ 5.200 bruto**
* Carga horária: **muito pesada**

👉 O estágio **não é renda**, é investimento.

---

## 🎯 Objetivo financeiro mínimo

Antes de sair do faturamento, você precisa atingir **UM** dos critérios abaixo:

### ✅ Critério A (mais seguro)

* Salário em TI ≥ **R$ 4.000 bruto**
* Contrato CLT ou PJ estável

### ✅ Critério B (mais estratégico)

* Salário em TI ≥ **R$ 3.500**
* Empresa com:

  * Plano de crescimento
  * Stack moderna
  * Time técnico melhor que você

---

## 📆 Linha do tempo sugerida

### 🔹 Agora → 6 meses

* Continuar estágio
* Aprender fundamentos sólidos:

  * Flutter
  * Consumo de API
  * State management
* Nenhuma decisão radical

### 🔹 6 → 12 meses

* Começar a aplicar para:

  * Flutter Júnior
  * Dev Mobile Júnior
* Salários alvo: **R$ 3k – 5k**
* Só sai do faturamento se:

  * Ganhar experiência REAL
  * Empresa tiver crescimento claro

### 🔹 12 → 24 meses

* Flutter Pleno inicial
* Salário esperado: **R$ 6k – 8k**
* Aqui a decisão fica óbvia:
  👉 **faturamento deixa de fazer sentido financeiro**

---

# 2️⃣ QUANDO EXATAMENTE SAIR DO FATURAMENTO

Vou ser bem específico 👇

## ❌ NÃO saia se:

* Estiver só como estagiário
* Estiver como júnior sem mentoria
* Salário < R$ 3.500
* Empresa sem time técnico

---

## ✅ SAIA IMEDIATAMENTE se:

* Receber proposta de dev Flutter:

  * ≥ **R$ 4.000**
  * Full-time
  * Com código real e entrega

📌 Mesmo que o salário seja igual ao de supervisor, **o potencial é infinitamente maior**.

---

## 🧠 Regra prática (guarde essa)

> **Nunca abandone uma carreira consolidada por uma promessa vaga.
> Abandone por uma oportunidade concreta.**

---

# 3️⃣ PÓS-GRADUAÇÃO IDEAL PARA SEU PERFIL

Você **não é um dev “puro”**, você é híbrido:
👉 **técnico + negócio + gestão**

Isso é raríssimo e valioso.

---

## ❌ Pós que NÃO recomendo agora

* “Desenvolvimento Mobile”
* “Flutter”
* “Programação em geral”

📌 Isso você aprende melhor trabalhando.

---

## ✅ Pós que COMBINAM com você (ordem de prioridade)

### 🥇 Arquitetura de Software

Melhor escolha técnica.

Você vai aprender:

* Clean Architecture
* SOLID
* Microsserviços
* Escalabilidade
* Decisões técnicas de alto nível

👉 Te posiciona para:

* Sênior
* Tech Lead
* Arquiteto

---

### 🥈 Engenharia de Software

Mais ampla, muito alinhada com seu curso.

Foco:

* Qualidade
* Processos
* Testes
* DevOps
* Métricas

---

### 🥉 Gestão de Tecnologia / Tech Management

Perfeita se você quiser unir:

* Liderança
* Código
* Produto

👉 Caminho natural para:

* Líder técnico
* Coordenador
* Gerente de TI

---

## ⏱️ Quando fazer a pós?

✔ Depois de estar trabalhando como dev
✔ Preferencialmente após 1–2 anos de experiência

Antes disso, **o retorno é menor**.

---

# 4️⃣ ANÁLISE DO SEU NÍVEL ATUAL EM FLUTTER (pelo histórico)

Com base em:

* Suas perguntas
* Seus erros
* Seu código
* Seus conceitos

## 📊 Avaliação honesta

### ✅ Pontos fortes

* Boa noção de arquitetura (Repository, Model)
* Preocupação com boas práticas
* Capacidade de entender APIs
* Maturidade profissional acima da média
* Curva de aprendizado boa

---

### ⚠️ Pontos que ainda faltam

(Comum para estágio, nada grave)

* State Management (Provider / Riverpod)
* Organização de pastas
* Tratamento de erros
* Performance
* Testes
* Código mais declarativo

👉 Tecnicamente hoje você está como:

> **Júnior inicial → Júnior intermediário (em evolução rápida)**

---

## 🎯 O que você precisa dominar para virar Júnior “contratável”

Checklist realista:

* ✅ Consumo de API REST
* 🔲 Provider ou Riverpod
* 🔲 Navegação organizada
* 🔲 Loading / erro / empty state
* 🔲 Publicar 1 app simples
* 🔲 Git sem medo

Com isso, você já compete por vaga.

---

# 🏁 CONCLUSÃO DIRETA

👉 **Você está no caminho certo**
👉 **Não é tarde**
👉 **Seu diferencial é visão de negócio + maturidade**

### A decisão correta NÃO é:

* “Largar tudo agora”
* “Ficar para sempre no faturamento”

### A decisão correta é:

> **Usar o faturamento como rede de segurança enquanto constrói a carreira em TI.**

---

Se quiser, no próximo passo posso:

* Criar um **checklist mensal (0–12 meses)**
* Simular **cenários salariais**
* Avaliar se você já pode aplicar para vagas
* Montar um **roadmap Flutter profissional**

Qual você quer fazer agora?

*/