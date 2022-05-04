//
//  ViewController.swift
//  Zar Atma Oyunu
//
//  Created by Mert Gaygusuz on 3.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var lblOyuncu1Skor: UILabel!
    
    @IBOutlet weak var lblOyuncu2Skor: UILabel!
    
    @IBOutlet weak var lblOyuncu1Puan: UILabel!
    
    @IBOutlet weak var lblOyuncu2Puan: UILabel!
    
    @IBOutlet weak var imgOyuncu1Durum: UIImageView!
    
    @IBOutlet weak var imgOyuncu2Durum: UIImageView!
    
    @IBOutlet weak var imgZar1: UIImageView!
    
    @IBOutlet weak var imgZar2: UIImageView!
    
    @IBOutlet weak var lblSetSonucu: UILabel!
    
    var oyuncuPuanlari = (birinciOyuncuPuani : 0, ikinciOyuncuPuani: 0)
    var oyuncuSkorlari = (birinciOyuncuSkoru: 0, ikinciOyuncuSkoru: 0)
    var oyuncuSirasi : Int = 1
    var maxSetSayisi : Int = 5
    var mevcutSet : Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let arkaplan = UIImage(named: "arkaplan"){ //arkaplanı ekledim
            self.view.backgroundColor = UIColor(patternImage: UIImage(named: "arkaplan")!)
        }
    }
    
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        
        if mevcutSet > maxSetSayisi{ //max set sayısını aşarsa program duracak
            return
        }
        
        zarDegerleriniUret()
    }

    
    func SetSonucu(zar1: Int, zar2: Int){
        if oyuncuSirasi == 1{
            
            oyuncuPuanlari.birinciOyuncuPuani = zar1+zar2
            lblOyuncu1Puan.text = String(oyuncuPuanlari.birinciOyuncuPuani)
            imgOyuncu1Durum.image = UIImage(named: "bekle")
            imgOyuncu2Durum.image = UIImage(named: "onay")
            lblSetSonucu.text = "Sıra 2.oyuncuda"
            oyuncuSirasi = 2
            lblOyuncu2Puan.text = "0"
        }
        else{
            oyuncuPuanlari.ikinciOyuncuPuani = zar1+zar2
            lblOyuncu2Puan.text = String(oyuncuPuanlari.ikinciOyuncuPuani)
            imgOyuncu2Durum.image = UIImage(named: "bekle")
            imgOyuncu1Durum.image = UIImage(named: "onay")
            oyuncuSirasi = 1
            
            //seti bitirme işlemi
            
            if oyuncuPuanlari.birinciOyuncuPuani > oyuncuPuanlari.ikinciOyuncuPuani{
                //buraya girerse 1.oyuncu oyunu kazanır
                oyuncuSkorlari.birinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(mevcutSet). Seti 1. Oyuncu kazandı"
                
                mevcutSet += 1 //mevcut seti bir arttırıyoruz
                lblOyuncu1Skor.text = String(oyuncuSkorlari.birinciOyuncuSkoru)
                
            }else if oyuncuPuanlari.ikinciOyuncuPuani > oyuncuPuanlari.birinciOyuncuPuani{
                //buraya girerse 2.oyuncu oyunu kazanır
                oyuncuSkorlari.ikinciOyuncuSkoru += 1
                lblSetSonucu.text = "\(mevcutSet). Seti 2. Oyuncu kazandı"
                
                mevcutSet += 1
                lblOyuncu2Skor.text = String(oyuncuSkorlari.ikinciOyuncuSkoru)
                
            }else{
                //Oyun berabere biter ve set sayısı değiştirilmez
                lblSetSonucu.text = "\(mevcutSet). Set berabere bitti"
                
            }
            
            oyuncuPuanlari.birinciOyuncuPuani = 0
            oyuncuPuanlari.ikinciOyuncuPuani = 0
        }
    }
    
    func zarDegerleriniUret(){
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            let zar1 = arc4random_uniform(6)+1 //random zar değerini üretiyoruz
            let zar2 = arc4random_uniform(6)+1
            
            self.imgZar1.image = UIImage(named: String(zar1)) //zar değerlerine göre image içeriğini buradan değiştiriyoruz
            self.imgZar2.image = UIImage(named: String(zar2))
            
            self.SetSonucu(zar1: Int(zar1), zar2: Int(zar2)) //parametreleri Inte çevirip setSonucu adlı fonksiyona yolluyoruz
            
            if self.mevcutSet > self.maxSetSayisi{ //oyun bitince kimin kazandığını kontrol edip sonucu yazdıracağız
                
                if self.oyuncuSkorlari.birinciOyuncuSkoru > self.oyuncuSkorlari.ikinciOyuncuSkoru{
                    
                    self.lblSetSonucu.text = "1.Oyuncu kazandı"
                }
                else{
                    
                    self.lblSetSonucu.text = "2.Oyuncu kazandı"
                }
            }
        }
        
        lblSetSonucu.text = "\(oyuncuSirasi).Oyuncu için zar atılıyor"
        imgZar1.image = UIImage(named: "bilinmeyenzar")
        imgZar2.image = UIImage(named: "bilinmeyenzar")
        
    }
}

