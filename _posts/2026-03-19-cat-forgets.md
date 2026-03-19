---
layout: post
title:  "Catastrophic Forgetting in 1D"
categories: deep learning
---

<p> What is the best way to demonstrate <a href = "https://en.wikipedia.org/wiki/Catastrophic_interference"> catastrophic forgetting </a> in 1D? Is 1D an oversimplification for this phenomenon that's seen in billion-dimensional neural networks? I am not sure. But here's what I came up with: </p>

<p>
Two disjoint domains. We train on domain A first, then train on domain B with the same learning rate. Think of these domains as distinct skills we would want neural networks to learn without forgetting past skills. </p>

<h3> Sequential Learning </h3>

<table>
  <tr>
    <th  colspan="2" align = "center">Two training runs</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/cat_forget/catastrophic_forgettin.mov">
</video></td>
  </tr>
</table>

<p> Note how quickly the model degrades on the first domain when we start training on the second. It takes just a single iteration. This is why it's called <i> catastrophic</i>. </p> 

<p>What happens when we train the same neural network on both domains in a single training run? </p>

<h3> Joint Training </h3>

<table>
  <tr>
    <th  colspan="2" align = "center">One training run</th>    
  </tr>  
  <tr>    
  </tr>
  <tr>    
    <td><video controls="controls" width="100%" autoplay loop muted>
  <source src="https://raw.githubusercontent.com/12345pnp/comp-play/gh-pages/assets/videos/cat_forget/catastrophic_forgetting_joint.mov">
</video></td>
  </tr>
</table>
