
//  ViewController.swift
//  Practice4
//
//  Created by Cristian Salomon Olmedo on 9/04/18.
//  Copyright © 2018 Cristian Salomon Olmedo. All rights reserved.
//
import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var poblacion = [[String]]()
    var chromosomeSize: Int = 0
    
    //Función invocada tras cargar la app
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        
        //Crear un tamaño par
        chromosomeSize = Int(arc4random_uniform(8)) + 1
        while(chromosomeSize % 2 != 0){
            chromosomeSize = Int(arc4random_uniform(8)) + 1
        }
        
        print("PRÁCTICA 4")
        print("\nTamaño de la población: \(chromosomeSize)")
        print("\n\n CRUZA UNIFORME\n\n")
        for _ in 0...9{
            crossUniform(couple: generateCouple())
        }
        print("\n\n CRUZA ACENTUADA\n\n")
        for _ in 0...9{
            crossAccented(couple: generateCouple())
        }
        
    }
    
    //Función que retorna el número de elementos en la tabla
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poblacion.count
    }
    
    //Función que inicializa los elementos de cada celda
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        
        return cell
    }

    //Botón que crea una nueva población, realiza las cruzas
    //y actualiza la tabla
    @IBAction func createButtonAction(_ sender: Any) {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Creación de arreglos de strings
        poblacion = [[String]]()

        self.tableView.reloadData()
    }
    
    
    //Esta función genera una pareja de cadenas de tamaño chromosomeSize
    func generateCouple() -> [String]{
        
        var padre = ""
        var madre = ""
        
        //La función arc4random crea números aleatorios
        //desde 0 hasta chromosomeSize-1
        for _ in 0..<chromosomeSize{
            padre += "\(Int(arc4random_uniform(2)))"
            madre += "\(Int(arc4random_uniform(2)))"
        }
        return [padre, madre]
    }
    

    func crossUniform(couple :[String]) -> [String]{
        
        let mother = Array(couple[0])
        let father = Array(couple[1])
        
        var crossPoints = ""
        var hijo1 = ""
        var hijo2 = ""
        
        //Crea un numero de puntos de cruza de no más de la mitad del cromosoma
        let nOfCrossPoints = Int(arc4random_uniform(UInt32(chromosomeSize/2))) + 1
        var remainingCP = nOfCrossPoints
        
        //Crea una cadena con los puntos de cruce
        for _ in 0..<chromosomeSize {
            
            if(remainingCP > 0){
                
                let number = Int(arc4random_uniform(2))
                
                if( number == 1){
                    crossPoints += "1"
                    remainingCP -= 1
                }
                else{
                    crossPoints += "0"
                }
            }else{
                crossPoints += "0"
            }
        }
        
        //Comienza a generar el hijo
        var cpArray = Array(crossPoints)
        
        for i in 0..<chromosomeSize{
            
            
            if(cpArray[i] == "0"){
                hijo1 += String(mother[i])
                hijo2 += String(father[i])
            }else{
                hijo1 += String(father[i])
                hijo2 += String(mother[i])
            }
            
        }
        
        print("Madre: " + String(mother))
        print("Padre: " + String(father))
        print("#Puntos de Cruza: \(nOfCrossPoints)")
        print("Puntos de cruza: \(cpArray)")
        print("Hijo 1: " + hijo1)
        print("Hijo2: " + hijo2)
        print("________________\n")
        
        
        return [hijo1, hijo2]
    }

    func crossAccented(couple: [String]) -> [String]{
    
        let mother = Array(couple[0])
        let father = Array(couple[1])
        
        var admirationMarkMother = [String]()
        var admirationMarkFather = [String]()
        
        var crossPointMother = ""
        var crossPointFather = ""
        
        var hijo1 = ""
        var hijo2 = ""
        
        var copiaActual = "madre"
        
        //Crea una cadena con los puntos de cruce
        for _ in 0..<chromosomeSize {
            crossPointMother += String(Int(arc4random_uniform(2)))
            crossPointFather += String(Int(arc4random_uniform(2)))
        }
        
        //Quitar repetidos
        //Convertir a arreglos los puntos de cruce
        var arrayCrossPointMother = Array(crossPointMother)
        var arrayCrossPointFather = Array(crossPointFather)
        
        for i in 0..<chromosomeSize{
            if(arrayCrossPointMother[i] == arrayCrossPointFather[i]){
                if(arrayCrossPointMother[i] == "0"){
                    arrayCrossPointMother[i] = "1"
                }else{
                    arrayCrossPointMother[i] = "0"
                }
            }
        }
        
        
        //Llenar con signos de admiracion
        
        for i in 0..<chromosomeSize{
            
            if(arrayCrossPointMother[i] == "1"){
                admirationMarkMother.append(String(mother[i]) + "!")
            }else{
                admirationMarkMother.append(String(mother[i]))
            }
            
            if(arrayCrossPointFather[i] == "1"){
                admirationMarkFather.append(String(father[i]) + "!")
            }else{
                admirationMarkFather.append(String(father[i]))
            }
            
        }
        
        for i in 0..<chromosomeSize{
            
            if(admirationMarkMother[i].range(of: "!") != nil || admirationMarkFather[i].range(of: "!") != nil){
                
                if(copiaActual == "madre"){
                    copiaActual = "padre"
                }else{
                    copiaActual = "madre"
                }
                
            }
            
            if(copiaActual == "madre"){
                hijo1 += admirationMarkMother[i]
                hijo2 += admirationMarkFather[i]
            }else{
                hijo1 += admirationMarkFather[i]
                hijo2 += admirationMarkMother[i]
            }
            
        }
        

        print("Madre: \(admirationMarkMother)")
        print("Padre: \(admirationMarkFather)")
        //print("PCM: \(arrayCrossPointMother)")
        //print("PCF: \(arrayCrossPointFather)")
        print("Hijo 1: " + hijo1)
        print("Hijo 2: " + hijo2)
        print("__________________")
        
        return [hijo1, hijo2]
        
    }
    
    
}

