import 'package:flutter/material.dart'; //Importar mtodos os componentes do Flutter

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true
      ),
      home: MediaEscolarPage()
    );
  }
}

class MediaEscolarPage extends StatefulWidget{
  const MediaEscolarPage({super.key});

  @override
  State<MediaEscolarPage> createState () => _MediaEscolarPageState();
  }

class _MediaEscolarPageState extends State<MediaEscolarPage>{
  
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController nota1Controller = TextEditingController();
  final TextEditingController nota2Controller = TextEditingController();
  final TextEditingController nota3Controller = TextEditingController();

  String nomeAluno= '';
  String situacao='';
  double media = 0;

  void calcularMedia(){
    String nome = nomeController.text.trim();

    double? nota1 = double.tryParse(
      nota1Controller.text.replaceAll(",", "."),
    );

     double? nota2 = double.tryParse(
      nota1Controller.text.replaceAll(",", "."),
    );

    
     double? nota3 = double.tryParse(
      nota1Controller.text.replaceAll(",", "."),
    );

    if(
      nome.isEmpty ||
       nota1 == null ||
        nota2 == null || 
        nota3 == null
      ){
      
      mostrarMensagem('Preencha os campos corretamente');
      return;
    }
    if(
      nota1 < 0 ||
      nota1 > 10 ||
      nota2 < 0 ||
      nota2 > 10 ||
      nota3 < 0 ||
      nota3 > 10
    ){
      mostrarMensagem('As notas devem estar entre 0 e 10.');
      return;
    }

    double mediaCalculada = (nota1 + nota2 + nota3) /3;

    String situacaoCalculada;

    if(mediaCalculada >=7){
      situacaoCalculada = 'APROVADO';
    }else if(mediaCalculada >=5){
      situacaoCalculada = 'RECUPERAÇÃO';
    }else{
      situacaoCalculada = 'REPROVADO';
    }
    setState(() {
      nomeAluno = nome;
      media = mediaCalculada;
      situacao
    });
  }

  void mostrarMensagem(String mensagem){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(mensagem)
        ),
    );
  }

  @override
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de Média"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.school,size: 80),   

            const SizedBox(height:10),     

            const Text(
              'Média Escolar',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(height:5,),
           
           const Text(
              'Digite o nome e as três notas do aluno',
              textAlign: TextAlign.center,
           ),

           const SizedBox(height: 25,),

           TextField(
              controller: nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do aluno',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
                hintText: 'Exemplo: Ana'
              ),
           ),

           const SizedBox(height: 15,),


           TextField(
              controller:nota1Controller,
              decoration: const InputDecoration(
                labelText: 'Nota 1',
                hintText: 'Digite uma nota de 0 a 10',
                border:OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true
              ),
           ),


            TextField(
              controller:nota1Controller,
              decoration: const InputDecoration(
                labelText: 'Nota 2',
                hintText: 'Digite uma nota de 0 a 10',
                border:OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true
              ),
           ),


            TextField(
              controller:nota1Controller,
              decoration: const InputDecoration(
                labelText: 'Nota 3',
                hintText: 'Digite uma nota de 0 a 10',
                border:OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true
              ),
           ),

           const SizedBox(height: 20,),

           ElevatedButton.icon(
            onPressed: (){},
            icon: const Icon(Icons.calculate),
            label: const Text('Calcular Média')
            ),

            const SizedBox(height: 25,),

            if(situacao.isNotEmpty)
            Card(
              child:Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      nomeAluno,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold
                        ),
                    ),
                
                  ],
                ),
              ),
            ),

          ],
        ),
        
      ),
    );
  }
}