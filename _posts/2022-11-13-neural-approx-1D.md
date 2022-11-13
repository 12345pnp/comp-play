---
layout: post
title:  "1D Function Approximation Using a Neural Network"
categories: neural networks
---
<p><i>[Or how to create a neural network from scratch. This post was mainly inspired by <a href="http://neuralnetworksanddeeplearning.com/">Michael Nielsen's book</a> on neural networks, and the <a href="https://web.njit.edu/~usman/courses/cs675_fall18/10.1.1.441.7873.pdf">1989 paper</a> by Cybenko. You can jump straight to the companion <a href="https://github.com/12345pnp/function_approximation_using_neural_networks/blob/master/neural_approx_1D.ipynb">notebook</a> if you like reading code more than tedious prose and awful jokes.]</i></p>

<h3>Points and Functions</h3>
<p>See these points?</p>
<table>
  <tr>
    <th colspan = 2 scope="col" align = "center">Random points on a grid, except they are not random.</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/points.png" alt="x square into cos 8 pi x, that's where these come from"></td>        
  </tr>
</table>

<p>They are drawn from a function. Like $\sin(x)$. Or $\cos(x)$. Or $\frac{\zeta(\log(x^5 + 1))}{1 - \exp(1 - \sin(x^2) - \cos(x^2))}$. Let's call it $\mathsf{y(\mathit{x})}$. It is univariate, which means it takes a single real number $x$ as its input. I have plotted  $\mathsf{y(\mathit{x})}$ for $200$ equispaced values of $x$ from $-1$ to $1$. Without knowing what $\mathsf{y(\mathit{x})}$ actually is, can we evaluate it for more values of $x$?  </p>

<p>We can certainly guess values in between the red dots. We can manually paint in more dots, but this isn't a sustainable, scalable, or elegant solution to this problem. What if we had millions of such points, for billions of unknown functions?</p>

<table>
  <tr>
    <th colspan = 2 scope="col" align = "center">Function approximation by MS Paint.</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/points_painted.png" alt="Tired - Python. Wired - MS Paint"></td>        
  </tr>
</table>

<p>What if, instead of trying to guess what function these points come from, or manually drawing dots, we chose a type of function that can be shaped into any curve, by adjusting its parameters? We can then use it to <i>approximate</i> our unknown function, based on the points we have. For example, the function $\mathsf{f(\mathit{x}) = a \mathit{x} + b}$ is parametrized by $\mathsf{a}$, and $\mathsf{b}$, which need to be fixed before evaluating the function for any input $\mathit{x}$. Therefore,  $\mathsf{a \mathit{x} + b}$ represents a family of functions, for different values of a, and b.</p>
<h3>The Sigmoid</h3>
Here is what the sigmoid function looks like.

<table>
  <tr>
    <th scope="col" align = "center"> $ \mathsf{ {\sigma} ({w \mathit{x} + b}) = \dfrac{1}{1 + e^{-(w \mathit{x} + b)}}}$</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/sigmoid.png" alt="The Sigmoid Freud"></td>  
  </tr>
</table>

<p>The sigmoid is parametrized by $\mathsf{w}$ and $\mathsf{b}$, which can be used to control the steepness and position  of the sigmoid. We can combine two sigmoids to get a shape like this:</p>

<table>
  <tr>
    <th scope="col" align = "center"> $ \mathsf{ \dfrac{1}{1 + e^{-(60 \mathit{x} + 200)}} - \dfrac{1}{1 + e^{-(60 \mathit{x} + 20)}} }$</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/sigmoid_stepf.png" alt="Sigmoid Stepford"></td>  
  </tr>
</table>

Let's call the above shape an <i>indicator</i>. Note that it is just a sum of two sigmoids. It is $1$ in a specific range, and $0$ everywhere else in the number line. We can scale (i.e. mutiply by a constant) and add any number of such indicators to approximate any shape to arbitrary precision. Below is a demonstration, where $n$ is the number of indicators I have used.

<table>
  <tr>
    <th colspan = 1 scope="col" align = "center">$n = 10$</th>
    <th colspan = 1 scope="col" align = "center">$n = 20$</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td ><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/indicator_approx_n10.png" alt="indicator_approx_n10"></td>
    <td ><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/indicator_approx_n20.png" alt="indicator_approx_n20"></td>    
  </tr>
  <tr>
    <th colspan = 1 scope="col" align = "center">$n = 30$</th>
    <th colspan = 1 scope="col" align = "center">$n = 40$</th>    
  </tr>
  <tr>    
    <td ><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/indicator_approx_n30.png" alt="indicator_approx_n30"></td>
    <td ><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/indicator_approx_n40.png" alt="indicator_approx_n40"></td>    
  </tr>
</table>


By increasing $n$ indefinitely, we can achieve arbitrary precision! But a few caveats:

- I did not use any sigmoids for the above plots, as that would have required me to find out the weights ($w$ and $b$) of all the sigmoids, and that involves <i>more maths</i>.
- The indicators above are simply the average of the target function in specific ranges (which become smaller as $n$ increases), and practically we cannot increase $n$ indefinitely in this method, because we have a limited sample of the target function.
- The point here was to provide a <a href = "http://neuralnetworksanddeeplearning.com/chap4.html">visual proof</a>, that sigmoids can approximate any function, <i>theoretically</i>. How to do it actually?

<h3>A modest neural network</h3>
Let us frame everything we have discussed so far mathematically.

- Any target function can be approximated up to arbitrary precision by adding a bunch of indicators, each multiplied by a different constant.
- An indicator can be approximated by adding two sigmoids, each parametrized uniquely.

Therefore

- Any target function can be approximated by a sum of sigmoids, each multiplied by a constant, and parametrized uniquely. Or, to to put it simply:

<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td align="center">
    $\mathsf{ {f} ( {x} )  = { \displaystyle\sum\limits_{k = 1}^L} \color{white}{v_k} \sigma( \color{white}{w_k} {x} + \color{white}{b_k} ) }$</td>
  </tr>  
  <tr>    
    <td align="center">The expression represents the summation of $\mathsf{L}$ sigmoids, each having parameters $\mathsf{w_k}$ and $\mathsf{b_k}$, and each multiplied by a constant $\mathsf{v_k}$, where $\mathsf{k}$ goes from $\mathsf{1}$ to $\mathsf{L}$. Therefore we have total $\mathsf{3L}$ parameters.</td>
  </tr>
</table>
This superposition of sigmoids can be represented as a simple neural network, with a single hidden layer of $\mathsf{L}$ nodes, having sigmoid activation, and a linear output layer.
<table>
  <tr>
    <th colspan = 2 scope="col" align = "center">A neural network with a single hidden layer</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td style="width:65%"><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/neural_1d_approx/neural_network_diagram.png" alt="Neural network with a single hidden layer and linear output layer"></td>
    <td>We have $\color{white}{\mathsf{L}}$ nodes, with sigmoid activation, each parametrized with weight $\color{white}{\mathsf{w_k}}$ and bias $\color{white}{\mathsf{b_k}}$, while the output layer is linear, with weight $\color{white}{\mathsf{v_k}}$ for each incoming result from the hidden layer</td>    
  </tr>
</table>
So how do we find the parameters $\mathsf{w_k}$, $\mathsf{b_k}$, and $\mathsf{v_k}$?

<h3>The Loss Function</h3>

<p>If I had a genie that could grant we any wish, I would ask him - please provide me the set of values for $\mathsf{w_k}$, $\mathsf{b_k}$, and $\mathsf{v_k}$, for which our bespoke function $\mathsf{f(x)}$ is as close as possible to the unknown target function $\mathsf{y}$. </p>

<p>In other words, dear genie, please minimize the distance between $\mathsf{f(x)}$ and  $\mathsf{y}$, for all the $n$ observed points of $\mathsf{y}$. The genie smiles and gives me the following function:</p>

<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td align="center">
    $\mathsf{ C(w, b, v) = \dfrac{1} {2n} \displaystyle\sum\limits_{i = 1}^{n}  (f({x_i}) - {y_i})^2 }$</td>
  </tr>  
  <tr>    
    <td align="center">This is known as the loss function, and our ideal parameter values should minimize this. For $n$ samples of the target function, we want our approximated function to minimize the error, i.e. get as close as possible to the given target values. We only want the distance between the two functions, we don't care if the difference between  them is $1$ or $-1$, which is where taking the square of their difference helps. We divide by $n$ to remove dependence of the error on the size of $n$. Why did we divide by $2$ as well? The genie said "It will be kind of convenient when you take the derivative bro". I don't know what that means</td>
  </tr>
</table>

<p>Now that we have formulated our wish into a function, we can proceed to minimize it and get our desired parameters. Note that this isn't the only possible loss function, you can get different ones, by asking more specific wishes to the genie.</p>

<h3>Gradient Descent</h3>

<p>To find best set of parameter values that minimize $\mathsf{ C(w, b, v) }$, we just need to iterate through all possible values of  $\mathsf{w_k}$, $\mathsf{b_k}$, and $\mathsf{v_k}$, and see where the loss function is lowest! The only problem is, our parameters are real numbers, and their possible values lie in the range $(-\infty , \infty )$.</p>

<p>For now, let's assign some random values to our parameters, and evaluate $\mathsf{ C(w, b, v) }$. If we're lucky these initial values might be the optimal ones. Possible, but very, very unlikely. We may not get the optimal result in a single shot, but what if we could move toward it, one step at a time?</p>

<p>The idea is simple - keep moving towards the direction $\mathsf{ C(w, b, v) }$ is decreasing, by using its gradient. If we carefully keep take our steps, we will eventually reach the minimum. Or, to put it simply:</p>

<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td align="center">
    $\mathsf{ w \longrightarrow w - \eta\dfrac{\partial C}{\partial w} }$</td>
    <td align="center">
    $\mathsf{ b \longrightarrow b - \eta\dfrac{\partial C}{\partial b} }$</td>
    <td align="center">
    $\mathsf{ v \longrightarrow v - \eta\dfrac{\partial C}{\partial v} }$</td>
  </tr>  
  <tr>    
    <td colspan = 3 align="center">We iteratively update our parameters by subtracting the gradient of $\mathsf{ C(w, b, v) }$ with respect to them (hence <i>partial</i> derivatives). $\mathsf{\eta}$ is a constant that determines the speed of our optimization, i.e. how carefully we are taking our steps. If it's too high, we might overstep and miss the minimum, but if it's too low, we might take a lot more time than necessary to reach our goal. $\mathsf{\eta}$ is called the <i>learning rate</i>, and is an example of a <i>hyper-parameter</i>, and we set its value based on heuristics, gut feelings, and astrology.</td>
  </tr>
</table>
<p>A quick note before we proceed - the derivative of the sigmoid is given by: </p>
<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td align="center">
    $\mathsf{\dfrac{d\sigma(\mathit{x})}{d\mathit{x}} = \sigma(\mathit{x})(1 - \sigma(\mathit{x}))   }$</td>
  </tr>
</table>
<p>Now we just need to find $\mathsf{ \dfrac{\partial C}{\partial w} }$, $\mathsf{ \dfrac{\partial C}{\partial b} }$, and $\mathsf{ \dfrac{\partial C}{\partial v} }$. Which requires application of the <a href="https://en.wikipedia.org/wiki/Chain_rule">chain rule</a>, and use of the sigmoid derivative formula we mentioned above. To put it simply: </p>

<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td align="center">
    $\mathsf{\dfrac{\partial C }{\partial {w_k} } =  \dfrac{1} {n} \displaystyle\sum\limits_{i = 1}^n (f(x_i) - y_i)  \dfrac{\partial f(x_i) }{\partial{w_k} } \\
   = \dfrac{1} {n} \displaystyle\sum\limits_{i = 1}^n (f(x_i) - y_i)  {v_k} \dfrac{\partial  \sigma( {w_k} {x_i} + {b_k} ) }{\partial {w_k} } \\
     = \dfrac{v_k} {n} \displaystyle\sum\limits_{i = 1}^n (f(x_i) - y_i)  \sigma( {w_k} {x_i} + {b_k} ) (1 - \sigma( {w_k} {x_i} + {b_k} )) x_i }$</td>
  </tr>
</table>

<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td align="center">
    $\mathsf{ \dfrac{\partial C }{\partial{b_k} } = \dfrac{v_k} {n} \displaystyle\sum\limits_{i = 1}^n (f(x_i) - y_i)  \sigma( {w_k} {x_i} + {b_k} ) (1 - \sigma( {w_k} {x_i} + {b_k} )) }$</td>
  </tr>
</table>

<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td align="center">
    $\mathsf{ \dfrac{\partial C }{\partial{v_k} } = \dfrac{1} {n} \displaystyle\sum\limits_{i = 1}^n (f(x_i) - y_i)  \sigma( {w_k} {x_i} + {b_k} ) }$</td>
  </tr>
</table>

<h3>The Algorithm</h3>
 - Choose some value for $\mathsf{L}$ - the number of nodes in the hidden layer. A large value might get a better fit, but will be slower and more computationally intensive, whereas a value too small may not lead to good fit.
 - Choose some value for $\mathsf{\eta}$ - a good value for $\mathsf{\eta}$ has to be determined experimentally.
 - Initialize the parameters to random values.
 - For a fixed number of iterations, update the values of all the parameters by gradient descent.
 - Profit.
<h3>Fun</h3>
Enough talk! Enough maths! Here are some animations -

<table>
  <tr>
    <th scope="col" align = "center">$\mathsf{L = 10, \eta = 0.05}$</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/neural_1d_approx/L5.mov">
</video></td>
  </tr>
</table>
It's trying, but clearly, 5 nodes are not enough. More nodes!

<table>
  <tr>
    <th scope="col" align = "center">$\mathsf{L = 25, \eta = 0.05}$</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/neural_1d_approx/L25.mov">
</video></td>
  </tr>
</table>

A lot more satisfying! But the fit isn't good enough towards the right. Let's increase $\mathsf{L}$ slightly more.

<table>
  <tr>
    <th  scope="col" align = "center">$\mathsf{L = 30, \eta = 0.05}$</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/neural_1d_approx/L30.mov">
</video></td>
  </tr>
</table>

That hits the spot! Look at it! Perfect. This is way better than Netflix.

We can try increasing $\mathsf{L}$ further but be careful - the curve might gain sentience and take over the planet.

To cap it off here is our neural net trying to fit over some other functions.

<table>
  <tr>
    <th  scope="col" align = "center">$\mathsf{L = 30, \eta = 0.05}$</th>
    <th  scope="col" align = "center">$\mathsf{L = 30, \eta = 0.05}$</th>     
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/neural_1d_approx/x2.mov">
</video></td>
<td><video controls="controls" width="100%" autoplay loop muted>
<source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/neural_1d_approx/sin8pi.mov">
</video></td>
  </tr>
  <tr>
    <th  scope="col" align = "center">$\mathsf{L = 30, \eta = 0.05}$</th>
    <th  scope="col" align = "center">$\mathsf{L = 50, \eta = 0.05}$</th>     
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/neural_1d_approx/bell.mov">
</video></td>
<td><video controls="controls" width="100%" autoplay loop muted>
<source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/neural_1d_approx/xplussinx.mov">
</video></td>
  </tr>
</table>

Here's the <a href="https://github.com/12345pnp/function_approximation_using_neural_networks/blob/master/neural_approx_1D.ipynb">notebook</a> where you can play with different functions.
