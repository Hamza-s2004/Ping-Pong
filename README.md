Developers
Hamza Shabbir
Muhammad Rajab
Contact
For inquiries or feedback, you can reach out via email:

hamzashabbirhs0123@gmail.com
mrajab0624@gmail.com
About
A simple interactive program written in NASM assembly language that simulates ball movement and optionally displays patterns based on user input. This project demonstrates low-level programming techniques and was designed for educational purposes, particularly for understanding assembly language concepts and DOSBox-based execution.

Introduction
This project is part of an assembly language learning experience. The primary objective is to develop a functional program in NASM that incorporates user interactivity, ball movement, and basic pattern generation. The program runs in DOSBox and allows users to experiment with enabling or disabling patterns and controlling the direction of a moving ball.

Features
User-controlled ball movement in a simulated environment.
Pattern generation based on user preferences.
Reset functionality to restore the ball to its initial position.
Customizable parameters for advanced users.
Requirements
Assembler: NASM (Netwide Assembler)
Emulator: DOSBox (for running 8086 assembly code)
How to Run
Set up your environment with NASM and DOSBox.
Assemble the .asm file to create a .COM executable.
bash
Copy code
nasm project.asm -o project.com  
Open DOSBox and navigate to the directory containing the .COM file.
bash
Copy code
mount c: /path/to/project  
c:  
project.com  
Controls
Arrow Keys: Move the ball in the desired direction.
P: Enable or disable patterns during the simulation.
R: Reset the ball to its original position.
ESC: Exit the program.
Future Improvements
Enhanced user interface with advanced visuals.
Additional movement logic and boundary conditions.
Integration of sound effects for user feedback.
Support for dynamic patterns with more complex behavior.
License
This project is intended for educational purposes only and is not for commercial use.
