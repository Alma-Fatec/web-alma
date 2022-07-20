import { useState, useEffect } from 'react'
import logo from './logo.svg'
import './App.css'


function App() {
  const [count, setCount] = useState(0)
  useEffect(() => {
    if (count) {
      console.log('Aprendendo sobre a nova ferramenta!');
    }
  }, [count]);



  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>Ryan Lindão</p>
        <p><strong>"eu acho que pinto"</strong></p>
        <p>
          <button type="button" onClick={() => setCount((count) => count + 1)}>
            Adicione pinto no bumbum do Maycon: {count}
          </button>
        </p>
        <p>
          Edit <code>App.tsx</code> and save to test HMR updates.
        </p>
        <p>
          <a
            className="App-link"
            href="https://reactjs.org"
            target="_blank"
            rel="noopener noreferrer"
          >
            Learn React
          </a>
          {' | '}
          <a
            className="App-link"
            href="https://vitejs.dev/guide/features.html"
            target="_blank"
            rel="noopener noreferrer"
          >
            Vite Docs
          </a>
        </p>
      </header>
    </div>
  )
}

export default App
