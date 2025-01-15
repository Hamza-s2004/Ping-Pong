# Pattern Pong  

## Developers  
- **Hamza Shabbir**  
- **Muhammad Rajab**  

## Contact  
For inquiries or feedback, you can reach out via email:  
- **hamzashabbirhs0123@gmail.com**
- **mrajab0624@gmail.com**  

## About  
**Pattern Pong** is an interactive program written in NASM assembly language. It simulates ball movement and allows users to enable or disable pattern generation. This project demonstrates low-level programming techniques and serves as an educational tool for learning assembly language concepts.  

**Features**:  
- User-controlled ball movement in a simulated environment.  
- Optional pattern generation based on user preferences.  
- Reset functionality to restore the ball to its initial position.  
- Customizable parameters for advanced users.  

---

## Requirements  
- **Assembler**: NASM (Netwide Assembler)  
- **Emulator**: DOSBox (for running 8086 assembly code)  

---

## How to Run  
1. **Set up your environment**: Install NASM and DOSBox.  
2. **Assemble the Code**: Use NASM to compile the assembly code into a `.COM` file:  
   ```bash
   nasm project.asm -o project.com
   ```
3. **Open DOSBox and navigate to the directory containing the .COM file:**
  ```bash
   mount c: /path/to/project
  ```
  ```bash
    c:
  ```
  ```bash
    project.com
  ```
