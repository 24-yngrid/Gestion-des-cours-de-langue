-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 19 avr. 2022 à 00:43
-- Version du serveur : 5.7.36
-- Version de PHP : 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `examen_web_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `auteur`
--

DROP TABLE IF EXISTS `auteur`;
CREATE TABLE IF NOT EXISTS `auteur` (
  `idauteur` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `datenaiss` date NOT NULL,
  `numeroCNI` varchar(100) NOT NULL,
  `anneeDebut` varchar(10) NOT NULL,
  PRIMARY KEY (`idauteur`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `auteur`
--

INSERT INTO `auteur` (`idauteur`, `nom`, `prenom`, `datenaiss`, `numeroCNI`, `anneeDebut`) VALUES
(1, 'atangana', 'jean', '1955-02-02', 'CMR001LT', '2001'),
(2, 'houafo', 'cabrel', '2002-02-02', 'LT000WI237', '2020');

-- --------------------------------------------------------

--
-- Structure de la table `emprunt`
--

DROP TABLE IF EXISTS `emprunt`;
CREATE TABLE IF NOT EXISTS `emprunt` (
  `idEmprunt` int(11) NOT NULL AUTO_INCREMENT,
  `numeroRef` int(11) NOT NULL,
  `idmembre` int(11) NOT NULL,
  `dateEmprunt` date NOT NULL,
  `dateRetourPrevu` date NOT NULL,
  PRIMARY KEY (`idEmprunt`),
  KEY `numeroRef` (`numeroRef`),
  KEY `idmembre` (`idmembre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `emprunt`
--

INSERT INTO `emprunt` (`idEmprunt`, `numeroRef`, `idmembre`, `dateEmprunt`, `dateRetourPrevu`) VALUES
(1, 3, 4, '2022-04-15', '2022-05-02'),
(2, 1, 4, '2022-04-15', '2022-05-20'),
(3, 1, 4, '2022-04-15', '2022-05-20');

-- --------------------------------------------------------

--
-- Structure de la table `exemplaire`
--

DROP TABLE IF EXISTS `exemplaire`;
CREATE TABLE IF NOT EXISTS `exemplaire` (
  `numeroRef` int(11) NOT NULL AUTO_INCREMENT,
  `dateAchat` date NOT NULL,
  `statusDispo` tinyint(1) NOT NULL,
  `isbn` varchar(10) NOT NULL,
  PRIMARY KEY (`numeroRef`),
  KEY `isbn` (`isbn`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `exemplaire`
--

INSERT INTO `exemplaire` (`numeroRef`, `dateAchat`, `statusDispo`, `isbn`) VALUES
(1, '2022-04-11', 1, 'L1'),
(2, '2022-04-10', 0, 'L2'),
(3, '2022-04-03', 1, 'L3'),
(4, '2022-04-15', 0, 'L4'),
(5, '2022-02-14', 1, 'L1'),
(6, '2022-01-05', 1, 'L1'),
(7, '2022-02-14', 1, 'L6'),
(8, '2022-01-05', 0, 'L7');

-- --------------------------------------------------------

--
-- Structure de la table `livre`
--

DROP TABLE IF EXISTS `livre`;
CREATE TABLE IF NOT EXISTS `livre` (
  `isbn` varchar(10) NOT NULL,
  `titre` varchar(20) NOT NULL,
  `anneeParution` date NOT NULL,
  `nombrePage` int(11) NOT NULL,
  `idauteur` int(11) NOT NULL,
  PRIMARY KEY (`isbn`),
  KEY `idauteur` (`idauteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `livre`
--

INSERT INTO `livre` (`isbn`, `titre`, `anneeParution`, `nombrePage`, `idauteur`) VALUES
('L1', 'la foi', '2022-04-03', 40, 1),
('L2', 'le courage', '2022-04-12', 20, 2),
('L3', 'la sagesse', '2022-04-04', 15, 1),
('L4', 'la force', '2022-04-07', 10, 2),
('L5', 'le bonheur', '2022-04-10', 60, 1),
('L6', 'la clef', '2022-04-13', 80, 1),
('L7', 'la jarde', '2022-04-07', 120, 2);

-- --------------------------------------------------------

--
-- Structure de la table `membre`
--

DROP TABLE IF EXISTS `membre`;
CREATE TABLE IF NOT EXISTS `membre` (
  `idmembre` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(20) NOT NULL,
  `prenom` varchar(20) NOT NULL,
  `datenaiss` date NOT NULL,
  `numeroCNI` varchar(100) NOT NULL,
  `telephone` varchar(40) NOT NULL,
  PRIMARY KEY (`idmembre`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `membre`
--

INSERT INTO `membre` (`idmembre`, `nom`, `prenom`, `datenaiss`, `numeroCNI`, `telephone`) VALUES
(1, 'tagne', 'cyrille', '2004-07-05', 'CMRT6GFT25', '+237654587560'),
(2, 'batikin', 'bryan', '2022-04-11', 'CMRY440UBA', '+237695566235'),
(3, 'edouard', 'fernand', '2002-01-05', 'GHYT5285', '+2645894855'),
(4, 'teresa', 'lepoint', '1980-12-05', 'GHGYFYTF6548', '+24844894565');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `emprunt`
--
ALTER TABLE `emprunt`
  ADD CONSTRAINT `fk_exemplaire_emprunt` FOREIGN KEY (`numeroRef`) REFERENCES `exemplaire` (`numeroRef`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_membre_emprunt` FOREIGN KEY (`idmembre`) REFERENCES `membre` (`idmembre`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `exemplaire`
--
ALTER TABLE `exemplaire`
  ADD CONSTRAINT `fk_livre_exemplaire` FOREIGN KEY (`isbn`) REFERENCES `livre` (`isbn`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Contraintes pour la table `livre`
--
ALTER TABLE `livre`
  ADD CONSTRAINT `fk_auteur_livre` FOREIGN KEY (`idauteur`) REFERENCES `auteur` (`idauteur`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
