<?php
 try {
     $connect=new PDO('mysql:host=localhost;dbname=examen','root','');
 } catch (Exception $e) {
     die('erreur'.$e->getMessage());
 }
 
     

    if (!empty($_POST['livre']) && !empty($_POST['membre']) && !empty($_POST['dte'])) {
       
       $liv=$_POST['livre'];
       $me=$_POST['membre'];
        $pr=date('y-m-d');
        $emp=$_POST['dte'];
        $reponse=$connect->prepare('INSERT INTO emprunt(numeroRef,idmembre,dateEmprunt,dateRetourPrevu) VALUES(?,?,?,?)');
        $reponse->execute(array($liv,$me,$pr,$emp));


    }


 
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BIBIO LE SAGE</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <div class="content">
        <div class="log">
            <p>biblio le sage</p>
        </div>
        <nav>
            <ul>
                <li><a href="">Emprunts</a></li>
                <li><a href="">Retours</a></li>
                <li><a href="">Livres</a></li>
                <li><a href="">Membres</a></li>
            </ul>
        </nav>
    </div>
    <div class="deb">
        <div class="ref">
            <div class="form">
                <form action="index.php" method="POST">

                    <div class="baf">
                        <div class="sr">
                            <h3>Ajouter un nouvel emprunt</h3>
                        </div>
                        <label>Livre :</label><br>
                        <?php $livre = $connect->query('SELECT DISTINCT *  FROM livre,exemplaire WHERE livre.isbn=exemplaire.isbn AND exemplaire.statusDispo=1'); ?>
                        <select name="livre" id="">
                            <option value="" selected>Selectionner un livre...</option>
                            <?php while ($l = $livre->fetch()) { ?>
                                <option value="<?php echo $l['numeroRef']; ?>"><?php echo $l['titre']; ?></option>
                            <?php
                            } ?>

                        </select><br>

                        <label>Emprunteur :</label><br>
                      <?php $mem = $connect->query('SELECT * FROM membre ORDER BY idmembre');?>
                        <select name="membre" id="">

                            <option value="" selected>Selectionner un membre...</option>
                            <?php while ($m = $mem->fetch()) { ?>
                                <option value="<?php echo $m['idmembre']; ?>"><?php echo $m['nom']; ?></option>
                            <?php
                            } ?>
                        </select><br>

                        <label>Date de retour :</label><br>
                        <input type="date" name="dte" id=""><br>
                        <div class="btn">
                            <button type="reset">Annuler</button>
                            <button type="submit" name="submit">Enregistrer</button>
                        </div>
                </form>
            </div>
        </div>
        <div class="taf">
            <div class="ds">
                <h3>LISTE DES LIVRES</h3>
            </div>
            <div class="table">
                <?php $get=$connect->query('SELECT DISTINCT * FROM livre,auteur,exemplaire WHERE livre.idauteur=auteur.idauteur AND livre.isbn=exemplaire.isbn '); ?>
                <table>
                    <tr>
                        <th>Titre</th>
                        <th>Auteur</th>
                        <th>Disponible</th>
                    </tr>
                    <?php while ($don=$get->fetch()) {?>
                    <tr>
                        <td> <?php echo $don['titre'];?></td>
                        <td><?php echo $don['nom'];?></td>
                        <td>
                            <?php
                            if ($don['statusDispo']==1) {
                                $cout=count(array($don['isbn']));
                            
                               echo $cout;
                            }else {
                                echo '<p style="color:red;">'."indisponible".'</p>';
                            }?>
                        </td>
                    </tr>
                    <?php    
                    }?>
                   
                </table>
            </div>
        </div>
    </div>
</body>

</html>