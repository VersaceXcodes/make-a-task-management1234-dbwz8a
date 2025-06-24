// Import the GV_GlobalSidebar component
import GV_GlobalSidebar from './components/views/GV_GlobalSidebar';

// Other imports
import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';

// App Component
declare function App(): JSX.Element;

const App = () => {
  return (
    <div className="App">
      <GV_GlobalSidebar />
      {/* Add other components here */}
    </div>
  );
};

export default App;

// Main render function
ReactDOM.render(<App />, document.getElementById('root'));
