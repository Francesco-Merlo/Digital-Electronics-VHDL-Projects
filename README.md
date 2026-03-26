# ⚡ Digital Electronics Projects

Repository che illustra progetti di **Elettronica Digitale**! 🚀
In questa repository illustriamo codici in **VHDL**, simulati e testati.

---

## 📂 Struttura del Repository

Qui sotto trovi i dettagli dei progetti sviluppati. **Clicca sui titoli** per espandere e leggere di più! 👇

<details>
<summary><b>1️⃣ 01_16bit_Adder</b></summary>
<br>
Progettazione di un sommatore a 16 bit a partire da componenti di base (Full Adders).
<ul>
  <li><code>full_adder.vhd</code>: Modulo base per l'addizione a 1 bit.</li>
  <li><code>adder_4bit.vhd</code>: Sommatore a 4 bit con carry (Ripple Carry Adder).</li>
  <li><code>adder_16bit.vhd</code>: Sommatore finale a 16 bit.</li>
  <li><code>tb_adder_16bit.vhd</code>: Testbench per la verifica del corretto funzionamento.</li>
</ul>
</details>

<details>
<summary><b>2️⃣ 02_Pipelined_Adder_Tree</b></summary>
<br>
Implementazione di un albero di somma (Adder Tree) ottimizzato tramite tecnica di <b>Pipelining</b> per massimizzare la frequenza di clock.
<ul>
  <li><code>AdderTree_Pipeline.vhd</code>: Top module del progetto.</li>
  <li><code>constraints.xdc</code>: File di vincoli per la sintesi su FPGA.</li>
  <li><code>tb_AdderTree.vhd</code>: Testbench con simulazione dei tempi di propagazione.</li>
</ul>
</details>

<details>
<summary><b>3️⃣ 03_Adder_Subtractor</b></summary>
<br>
Circuito aritmetico combinatorio in grado di eseguire sia addizioni che sottrazioni, gestendo correttamente casi di <b>Overflow</b> e numeri negativi (complemento a 2).
<ul>
  <li><code>Progetto.vhd</code>: Modulo principale (Sommatore/Sottrattore).</li>
  <li><code>tb_Progetto.vhd</code>: Testbench completo di vari scenari (numeri positivi, negativi, limite di overflow).</li>
</ul>
</details>

---

## 🛠️ Strumenti Utilizzati

* **Linguaggio:** VHDL
* **Editor:** Visual Studio Code
* **Sintesi e Simulazione:** Xilinx Vivado (o tool equivalente come ModelSim o GHDL)

---

## 🚀 Come testare i moduli

1. **Clona il repository** sul tuo PC aprendo il terminale e digitando:

   ```bash
   git clone git clone https://github.com/Francesco-Merlo/Digital-Electronics-Projects.git
