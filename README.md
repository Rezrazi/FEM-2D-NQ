# MEF Elements de type NQ1/NQ2
![GitHub](https://img.shields.io/github/license/rezrazi/FEM-2D-NQ.svg?style=plastic) 
![GitHub release](https://img.shields.io/github/release/rezrazi/FEM-2D-NQ.svg?style=plastic)


## Introduction
Les fichiers présents sur ce dépôt permettent d'évaluer la solution  d'un problème mis sous forme d'équation différentielle sur un domaine de dimension 2D définit par sa frontière de telle sorte que la solution est nulle sur celle ci.
L'utilisateur sera requis d'entrer les valeur de sa choix pour la configuration initiale du script, qui serviront à déterminer le type d'éléments finis à utiliser (NQ1/NQ2), le nombre de points de Gauss pour l'intégration numérique et le nombre d'éléments suivant chaque axe du domaine 2D.

## Procédures
- Maillage du domaine 2D selon le type d'éléments et leurs nombre.
- Calcul les éléments relatifs à la quadrature de Gauss.
- Evaluation les fonctions de forme.
- Génération les matrices élémentaires et second membre.
- Assemblage des matrices élémentaires.
- Calcul de la solution.

## Description des fichiers
### Maillage2D
Permet de générer un maillage sur un domaine 2D définit par les paramètres suivants :
- Frontière sur chaque axe.
- Type d'éléments finis.
- Nombre d'éléments suivant chaque axe.

_**Exemples**_
![maillage.png](https://i.imgur.com/ttXTYLo.png)


![maillage2.png](https://i.imgur.com/STx4gEN.png)

### Quadrature
Fonction qui donne les poids et les noeuds de Gauss en 2D suivant le type d'élément et le nombre de points de calcul de l'intégration numérique de Gauss.

### FoncChap
Evaluation des fonction chapeaux, leur forme globale a étée déterminé par Maple. Ce script calcule les valeur des coefficients des fonctions de forme.

### MatElem2D SMelem
Génération des matrices élémentaires de rigidité et second membre en utilisant les fonctions chapeaux et les évaluant sur chaque élément du maillage.

### Assemblage2D
Assemblage des matrices élémentaires en matrices globales sur la totalité du domaine.

### MEF2D
Regroupe les étapes et initie le calcul de la solution évaluée aux noeuds du maillage du domaine.

### Affichage
Affiche la solution interpolée sur un maillage secondaire pour éviter les problèmes d'affichage triangulaire au lieu d'un affichage rectangulaire.

### Main
Script principal du programme, contient toutes les entrées et l'enchainement des étapes ainsi que l'affichage final et l'évaluation de l'erreur.

## Exemple de solution évaluée
### Données
- Domaine : `(-2 2)` x `(-1 1)`
- Type d'éléments : `nq1`
- Points de Gauss : `4`
- Nombre d'éléments : `8` x `8`

### Résultats
- Approchée
![approchee.png](https://i.imgur.com/21XqFnm.png)

- Exacte
![exacte.png](https://i.imgur.com/5AE0CRf.png)

### Evaluation de l'érreur
|Nombre d'éléments total |Erreur norme L2          |Erreur relative        |
|----------------------- |------------------------ |---------------------- |
|64                      |6.4076500339013243e-01   |3.7666761480123384e+01 |
|256                     |3.1571845434976814e-01   |1.5289501206979500e+02 |
|1024                    |1.5727399187148874e-01   |6.1385635955881662e+02 |
|4096                    |7.8563778713928500e-02   |2.4577139001903406e+03 |
   
