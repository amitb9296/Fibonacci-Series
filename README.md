
# Fibonacci Series



The Fibonacci numbers constitute a sequence defined as

               {          0         .... if i = 0 
      fib(i) = {          1	        .... if i = 1
               { fib(i-1) + fib(i-2).... if i > 1

One way to calculate fib(i) is to construct the function iteratively, from 0 to the desired i value.
So we need two temporary registers to store the two most recently calculated values[i.e.fib(i-1) & fib(i-2)] and one index register to keep track of the number of the iterations.

t1 and t0 are temporary storage registers and n is the index register. In addition to the regular data input and output signals, i and f , we include a command signal, start, which signals the beginning of operation, and two status signals: ready, which indicates that the circuit is idle and ready to take new input, and done, which is asserted for one clock cycle when the operation is completed.

The ASMD chart has three states. The IDLE state indicates that the circuit is currently IDLE. When start is asserted, the FSMD moves to the op state and loads initial values to three registers. The t0 and t1 registers are loaded with 0 and 1, which represent fib(0) and fib(1), respectively. The n register is loaded with i, the desired number of iterations.The main computation is iterated through the OPERATE state by three RT operations:-

                  t1 <-- t1 + t0
                  t0 <-- t1
                  n  <-- n - 1
The first two RT operations obtain a new value and store the two most recently calculated values in t1 and t0. The third RT operation decrements the iteration index. The iteration ended when n reaches 1 or its initial value is 0 [i.e., fib(0)].

NOTE: The new values of the t1 and t0 registers are loaded at the same time when the FSMD exits the OPERATE state (i.e., at the next rising edge of the clock). Thus, the original value of t1,not (t1 + t0) , is stored to t0. 

The purpose of the DONE state is to generate the one-clock-cycle done signal to indicate completion of the computation.
