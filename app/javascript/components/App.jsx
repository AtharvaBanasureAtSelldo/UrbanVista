import React from "react";

const App = () => {
  return (
    <div class="container text-center">
      <div className="p-4 bg-light rounded shadow">
        <img 
        src="/banner.png" 
        alt="Urban Vista" 
        class="img-fluid rounded mb-3" 
        style={{
          maxWidth: "100%",
          height: "auto"
        }}/>
        <h1 className="fw-bold text-dark">Welcome to Urban Vista</h1>
        <p className="fs-5 text-secondary">Simplifying Real Estate</p>
      </div>
    </div>
  )
 
};

export default App;
