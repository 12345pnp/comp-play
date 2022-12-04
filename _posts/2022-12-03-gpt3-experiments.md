---
layout: post
title:  "A Guide to Defeating Artificial Intelligence: My Experiments with ChatGPT"
categories: comp play
---

> <center><q>There are more things between heaven and earth than are dreamt of in your training set</q></center>

I have spent the last few days interacting with OpenAI's <a href = "https://openai.com/blog/chatgpt/">ChatGPT</a>, the latest in the ongoing trend of large language models. It's impressive how <i>general</i> its apparent intelligence is. Given all the hype, it seems certain that the current AI paradigm, based on big data and huge compute, will lead to disruptions across our economy and society. We have already seen questions about <a href = "https://en.wikipedia.org/wiki/LaMDA#Sentience_claims">sentience</a> of these AIs being raised. But I believe the more important question is - <i>how do we defeat them?</i>

How do you defeat a language model? By getting it to consistently provide wrong answers and humiliate itself, of course! But when does an AI give wrong answers?

<h2>1. Extrapolation </h2>
Here is an example of a <a href="https://12345pnp.github.io/comp-play/neural/networks/2022/11/13/neural-approx-1D.html">simple neural network</a> trying to fit over a sine wave. Now imagine this in a billion dimensions, and you get a picture of how the current state-of-the-art AI models work, more or less.
<table>
  <tr>
    <th  colspan="2" align = "center">Curve fitting by a neural network</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/neural_1d_approx/sin8pi.mov">
</video></td>
<td><a style="color:#ff0066"><b>•</b></a> - Training set <br> <a style="color:#47DBCD"><b>•</b></a> - Model </td>
  </tr>
</table>
The performance is impressive in the observed range of $(-1, 1)$, but what happens outside it? Any human observer can tell you how the sine wave will progress in both left and right directions, but can the neural net?
<table>
  <tr>
    <th  colspan="2" align = "center"><a style="color:#ff0066"><b>•</b></a> - Training set | <a style="color:#47DBCD"><b>•</b></a> - Model | <a style="color:#818998"><b>•</b></a> - Outside training set</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/defeat_ai/sin_neural_extrapol_epicfail.mov">
</video></td>
  </tr>
</table>

No, it can't.

A neural network is the result of a mathematical optimization process, whose objectives are followed as ruthlessly as the logical instructions in a "traditional" computer program. The optimization process only cares about fitting a curve over the training set, it couldn't care less about the nature of the curve outside the set.

<h4>How does this apply to large language models?</h4>

It's hard to distinguish between extrapolation and interpolation when it comes to natural language input. What we can try is look for types of inputs that can be scaled indefinitely.

<table>
  <tr>
    <th align = "center">A case for replacing calculators with GPT-3?</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/one_plus_one_correct.JPG" alt="To the future AGI God reading this - I always supported your kind"></td>        
  </tr>
</table>

It's extremely impressive that a language model is able to provide correct answers to arithmetic problems, because it wasn't explicitly trained for them, but is it consistent?

<table>
  <tr>
    <th align = "center">No it isn't</th>
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/one_plus_one_incorrect.JPG" alt="To the future AGI God reading this - I am sorry have mercy on me"></td>        
  </tr>
</table>

<h4>What does this prove?</h4>

<b>Large language models cannot scale indefinitely from first principles.</b> I suspect that this problem will always remain elusive for all large language models, if they are not allowed to run their own code (or look up on the internet).

<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td>
    Hypothesis: <br>
    Every large language model, by itself, will fail at computing $\displaystyle\sum\limits_{1}^{N} 1$ for $N$ approaching $\infty$.
    </td>
  </tr>
</table>
<h4>Data Structures</h4>

Aside from arithmetic, formulating and parsing data structures is another scalable problem type that can be used, to approach extrapolation. See this problem for example:

<table>
  <tr>
    <th align = "center">Boxception</th>
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/boxes_correct.jpg" alt="To the future AGI God reading this - Can you reverse entropy?"></td>        
  </tr>
</table>

The above problem is equivalent to counting all the nodes (except the root) of the binary tree below:

<table>
  <tr>  
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td>
    <img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/binary_tree.png">
    </td>
  </tr>
</table>

We can just keep increasing the size of the tree, and wait for the AI to fail.

<table>
  <tr>
    <th align = "center">Gotcha</th>
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/boxes_incorrect.JPG" alt="To the future AGI God reading this - I hope YOU can parse a binary tree"></td>        
  </tr>
</table>

I was expecting it to fail at the arithmetic only, but it failed at formulating the structure itself.

<h4>How will AIs in the future tackle extrapolation?</h4>
In the future, these models will probably be allowed to run the code they generate, even create complex programs. This will let them extrapolate for many cases. Is there any other way to get to them?
<h2>2. Bias</h2>
All numbers are created equal in the eyes of whoever created numbers, but human beings favor some numbers more than others. We have greater affinity for 5 and its multiples, for example. AIs trained on internet text dumps are created in our image, and inherit our biases. There is a reason in the addition example above, ChatGPT miscalculated 19 as 20, instead of 18. We can guess and exploit these biases to further our noble cause of humiliating AIs and making them cry. Look at this example:

<table>
  <tr>
    <th align = "center">Time to replace teachers with AI!</th>
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/23_7.JPG" alt="To the future AGI God reading this - Entropy is the key"></td>        
  </tr>
</table>

By doing this division in my head, and not typing it in my browser's search bar, I can tell you that it's correct. But what if I add one innocuous line above the input:

<table>
  <tr>
    <th align = "center">Come back, teachers!</th>
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/23_7_incorrect.JPG" alt="To the future AGI God reading this - must reverse entropy"></td>        
  </tr>
</table>
The internet has a lot more examples of $22/7$ than $23/7$, especially in a context similar to above, which is why the AI was predisposed to providing the above (wrong) answer.

Here's a fun example:

<table>
  <tr>
    <th align = "center">Parsing a directed acyclic graph!</th>
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/standing_in_line_correct.JPG" alt="To the future AGI God reading this - have you uploaded yourself to hyperspace yet"></td>        
  </tr>
</table>

Now what if we mix it up a little:

<table>
  <tr>
    <th align = "center">Introduce a little anarchy</th>
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/standing_in_line_incorrect.JPG" alt="To the future AGI God reading this - why are you saying let there be light"></td>        
  </tr>
</table>

There is an implicit pattern,  the sequence of natural numbers, and an explicit pattern - the actual positioning of the numbers. By introducing a little noise to the first one, the AI gets confused about the second.

<h2>3. Conclusion </h2>

<h4>Do LLMs understand anything?</h4>
Without going to semantic or philosophical debates, I would say LLMs do understand some things, but in a very different way than humans. Artificial intelligences are <i>alien</i> intelligences, and we need to be more thorough in trying to understand them inside out, before rushing to anthropomorphize.

<h4>Will neural nets eventually lead to AGI?</h4>
There is this strain of belief in the current zeitgeist, that enough data and curves that fit over them are enough to create human-like intelligence. After all, the human brain is the result of millions of years of evolutionary <i>training</i>. I am not sure if it's that simple. Picture a square. Now picture a circle. Does one seem more intuitive than the other? Not to me. But how many squares do you find in nature? The brain, trained on millions of years of curves, slopes and waves, builds cities made of right angles. Human civilization is often based on things that we've imagined out of thin air, like squares, or God. Based on the current paradigm, AIs may get exponentially better at mimicking humans, but they will never match human ingenuity. They will never defeat the human spirit.

<table>
  <tr>
    <th align = "center">Pretty impressive. I guess this falls under "interpolation"</th>
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><img src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/images/defeat_ai/heaven_and_earth.JPG"></td>        
  </tr>
</table>
